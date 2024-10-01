local km = require("utils.km")

local function nixPath(bin)
  return "/run/current-system/sw/bin/" .. bin
end

return {
  "neovim/nvim-lspconfig",
  config = function()
    local nvim_lsp = require("lspconfig")

    local capz = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- All LSP servers get cool keybindings
    --km.set("pr", lsp_utils.rename_symbol, "[L]sp [R]ename")
    km.set("ph", vim.lsp.buf.hover, "LS[P] [H]over")
    --km.set("pu", lsp_utils.find_usages, "[L]sp [U]sages")

    -- Lua specific config
    nvim_lsp.lua_ls.setup({
      cmd = { nixPath("lua-language-server"), "-E" },
      capabilities = capz,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- Nix specific config
    nvim_lsp.nil_ls.setup({
      capabilities = capz,
    })

    -- Golang specific config
    nvim_lsp.gopls.setup({
      capabilities = capz,
      cmd = { nixPath("gopls"), "serve" },
      filetypes = { "go", "gomod", "gowork" },
      root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
    })
  end,
}
