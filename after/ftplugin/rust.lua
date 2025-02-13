vim.keymap.set('n', 'gC', function()
  vim.cmd.RustLsp 'openCargo'
end, { desc = 'Open Cargo.toml' })
