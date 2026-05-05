local servers = {
    lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.git', 'lua' },
        settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          signatureHelp = { enabled = true },
        },
      },
    },
    zls = {
        cmd = { 'zls' },
        filetypes = { 'zig', 'zig.zon' },
        root_markers = { '.git', 'build.zig', 'build.zig.zon', 'zig-out', '.zig-cache' },
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend(
  'force',
  capabilities,
  require('blink.cmp').get_lsp_capabilities({}, false)
)

for server, config in pairs(servers) do
    config.capabilities = capabilities
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end
