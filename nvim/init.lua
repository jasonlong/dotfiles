local modules = {
  "plugins",
  "config",
  "keymaps"
}

for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    return
  end
end
