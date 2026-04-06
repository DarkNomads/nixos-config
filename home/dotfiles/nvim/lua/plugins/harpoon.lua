vim.pack.add({
  "https://github.com/ThePrimeagen/harpoon",
  "https://github.com/nvim-lua/plenary.nvim",
})

require("harpoon").setup({
  menu = { width = 80 },
})

vim.keymap.set("n", "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h1", ":lua require('harpoon.ui').nav_file(1)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h2", ":lua require('harpoon.ui').nav_file(2)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h3", ":lua require('harpoon.ui').nav_file(3)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h4", ":lua require('harpoon.ui').nav_file(4)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h5", ":lua require('harpoon.ui').nav_file(5)<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", { pattern = "harpoon", callback = function() vim.opt_local.ruler = false end })

