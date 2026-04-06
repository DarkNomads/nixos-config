vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.keymap.set( "n", "gD", vim.lsp.buf.declaration, {} )
vim.keymap.set( "n", "gd", vim.lsp.buf.definition, {} )
vim.keymap.set( "n", "K", vim.lsp.buf.hover, {} )
vim.keymap.set( "n", "gi", vim.lsp.buf.implementation, {} )
vim.keymap.set( "n", "<C-k>", vim.lsp.buf.signature_help, {} )
vim.keymap.set( "n", "<leader>ca", vim.lsp.buf.code_action, {} )

vim.lsp.config("lua_ls", { capabilities = capabilities })
vim.lsp.config("ts_ls", { capabilities = capabilities })

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
})
