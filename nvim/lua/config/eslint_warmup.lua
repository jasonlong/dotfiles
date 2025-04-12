-- Warmup eslint_d by running a no-op lint command when a relevant file is opened
-- This triggers eslint_d to parse the project's ESLint config before the first save

local function warmup_eslint_d()
  -- Get the full path of the current buffer
  local filepath = vim.fn.expand("%:p")
  if not filepath or filepath == "" then
    return
  end

  -- Find the project root (where package.json is)
  local project_root = vim.fn.finddir("node_modules/..", filepath .. ";")
  if not project_root or project_root == "" then
    return
  end

  -- Run eslint_d in a background job to warm it up
  -- The --fix-dry-run flag makes this a no-op that still forces eslint_d to parse the config
  vim.fn.jobstart({ "eslint_d", "--fix-dry-run", filepath }, {
    detach = true,
    cwd = project_root,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.schedule(function()
          vim.notify("eslint_d warmed up for " .. project_root, vim.log.levels.DEBUG)
        end)
      end
    end,
  })
end

-- Run the warmup when a relevant file is opened
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.vue", "*.svelte" },
  callback = function()
    -- Use defer_fn to run this slightly after the file is opened
    vim.defer_fn(function()
      warmup_eslint_d()
    end, 300) -- 300ms delay to avoid blocking the UI
  end,
  desc = "Warm up eslint_d on file open",
})