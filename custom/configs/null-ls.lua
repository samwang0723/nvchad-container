local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local opts = {
  debug = false,
  sources = {
    -- StyLua
    formatting.stylua,
    -- Golang
    formatting.gofumpt,
    formatting.goimports_reviser,
    formatting.golines,
    -- Python
    formatting.black.with { extra_args = { "--fast" } },
    -- Prettier
    formatting.prettier.with {
      filetypes = {
        "javascript",
        "typescript",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "go",
        "ruby",
        "lua",
      },
      command = "prettier",
      args = { "--config", vim.env.HOME .. "/.prettierrc.yml", "-" },
      to_stdin = true,
    },
    diagnostics.eslint_d.with { -- Mason or npm install -g eslint_d
      diagnostics_format = "[eslint] #{m}\n(#{c})",
    },
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
return opts
