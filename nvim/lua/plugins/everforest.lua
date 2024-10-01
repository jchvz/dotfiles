return {
  "sainnhe/everforest",
  config = function()
    vim.o.background = "light"
    vim.g.everforest_enable_italic = 0
    vim.g.everforest_background = "medium"

    -- Activate the colorscheme
    vim.cmd("colorscheme everforest")

    -- Make background transparent for Normal and Float windows
    --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
}
