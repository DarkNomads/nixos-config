vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.termguicolors = true

vim.opt.splitright = true

vim.opt.statusline = "%#LineNr# %F %m"
vim.opt.showmode = false

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
