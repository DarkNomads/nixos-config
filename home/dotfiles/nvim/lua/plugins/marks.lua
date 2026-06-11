vim.pack.add({ "https://github.com/chentoast/marks.nvim" })

require("marks").setup()

local group = vim.api.nvim_create_augroup("marks-fix-hl", {})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = group,
  callback = function()
    vim.api.nvim_set_hl(0, "MarkSignNumHL", {})
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(_)
    local marks = require("marks")
    vim.schedule(function() marks.refresh(_) end)
  end,
})
