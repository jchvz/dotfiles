-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

vim.keymap.set("n", "<leader>z", function()
  require("zen-mode").toggle({
    window = { width = 96 },
  })
end, { desc = "Toggle Zen Mode" })
