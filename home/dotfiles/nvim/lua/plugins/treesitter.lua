vim.pack.add({{
  src = "https://github.com/nvim-treesitter/nvim-treesitter",
  data = { run = function() vim.cmd("TSUpdate") end },
}})

require("nvim-treesitter").install({
  "nix",
  "typescript",
  "ruby",
  "html",
  "css",
})

local highlight_fn = function() vim.treesitter.start() end
vim.api.nvim_create_autocmd("FileType", { pattern = { "nix" }, callback = highlight_fn })
vim.api.nvim_create_autocmd("FileType", { pattern = { "typescript" }, callback = highlight_fn })
vim.api.nvim_create_autocmd("FileType", { pattern = { "html" }, callback = highlight_fn })
vim.api.nvim_create_autocmd("FileType", { pattern = { "css" }, callback = highlight_fn })
vim.api.nvim_create_autocmd("FileType", { pattern = { "ruby" }, callback = highlight_fn })
