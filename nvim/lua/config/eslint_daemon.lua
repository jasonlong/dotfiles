-- Start and maintain eslint_d daemon for JavaScript/TypeScript projects
-- This ensures the daemon is running before any formatting operations and keeps it alive

-- Keep track of where we tried starting eslint_d within this Neovim session
local started_eslint_d_dirs = {}
-- Store timer IDs for each project directory
local keepalive_timers = {}

-- Function to start eslint_d daemon for a project
local function start_eslint_d(project_dir)
  if not started_eslint_d_dirs[project_dir] then
    vim.notify("Starting eslint_d daemon for project: " .. project_dir, vim.log.levels.INFO)
    vim.fn.jobstart({ "eslint_d", "start" }, {
      detach = true,
      cwd = project_dir,
    })
    started_eslint_d_dirs[project_dir] = true
  end
end

-- Function to check if eslint_d is running and restart if needed
local function check_and_restart_eslint_d(project_dir)
  -- Use the ping command to check if eslint_d is responsive
  vim.fn.jobstart({ "eslint_d", "status" }, {
    cwd = project_dir,
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data or #data == 0 or (data[1] == "" and #data == 1) then
        return
      end

      -- If we get a response, eslint_d is running
      -- Do nothing as it's already running
    end,
    on_exit = function(_, exit_code)
      -- If ping fails (non-zero exit code), restart the daemon
      if exit_code ~= 0 then
        vim.notify("eslint_d is not running for " .. project_dir .. ", restarting...", vim.log.levels.WARN)
        start_eslint_d(project_dir)
      end
    end,
  })
end

-- Set up a keepalive timer for a project
local function setup_keepalive(project_dir)
  -- Cancel any existing timer for this project
  if keepalive_timers[project_dir] then
    vim.fn.timer_stop(keepalive_timers[project_dir])
    keepalive_timers[project_dir] = nil
  end

  -- Create a new timer that runs every 5 minutes (300000 ms)
  local timer_id = vim.fn.timer_start(300000, function()
    check_and_restart_eslint_d(project_dir)
    -- This is a repeating timer
  end, { ['repeat'] = -1 }) -- -1 means repeat indefinitely

  keepalive_timers[project_dir] = timer_id
end

-- Find and ensure eslint_d daemon is running when entering a JS/TS file
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.vue", "*.svelte" },
  callback = function()
    -- Get the directory of the current buffer
    local current_buf_dir = vim.fn.expand("%:p:h")
    if not current_buf_dir or current_buf_dir == "" then
      return
    end

    -- Find package.json to determine project root
    local proj_dir_marker = vim.fn.findfile("package.json", current_buf_dir .. ";")

    if proj_dir_marker and proj_dir_marker ~= "" then
      -- Get the directory containing package.json (the project root)
      local project_dir = vim.fn.fnamemodify(proj_dir_marker, ":h")

      -- Start the daemon if not already started
      start_eslint_d(project_dir)

      -- Set up keepalive timer
      setup_keepalive(project_dir)
    end
  end,
  desc = "Start eslint_d daemon and keep it alive for JS/TS projects",
})

-- Clean up timers when Neovim exits
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    for proj_dir, timer_id in pairs(keepalive_timers) do
      if timer_id then
        vim.fn.timer_stop(timer_id)
        keepalive_timers[proj_dir] = nil
      end
    end
  end,
  desc = "Clean up eslint_d keepalive timers on exit",
})

-- Also check eslint_d status before saving to ensure it's running
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.vue", "*.svelte" },
  callback = function()
    local current_buf_dir = vim.fn.expand("%:p:h")
    if not current_buf_dir or current_buf_dir == "" then
      return
    end

    local proj_dir_marker = vim.fn.findfile("package.json", current_buf_dir .. ";")

    if proj_dir_marker and proj_dir_marker ~= "" then
      local project_dir = vim.fn.fnamemodify(proj_dir_marker, ":h")
      check_and_restart_eslint_d(project_dir)
    end
  end,
  desc = "Check eslint_d status before saving",
})