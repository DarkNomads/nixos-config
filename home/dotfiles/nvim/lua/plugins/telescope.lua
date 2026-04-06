vim.pack.add({
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

require("telescope").setup({
  defaults = {
    mappings = {
      n = { ["<C-p>"] = require("telescope.actions.layout").toggle_preview },
      i = { ["<C-p>"] = require("telescope.actions.layout").toggle_preview }
    },
    preview = { hide_on_startup = true },
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>FF", function() builtin.find_files({ hidden = true, no_ignore = true }) end)
vim.keymap.set("n", "<leader>FG", function() builtin.live_grep({ hidden = true, no_ignore = true }) end)

vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopePrompt", callback = function() vim.opt_local.ruler = false end })
