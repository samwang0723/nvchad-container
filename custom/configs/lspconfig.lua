local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      staticcheck = false,
      usePlaceholders = true,
      semanticTokens = true,
      codelenses = {
        generate = true,
        test = true,
      },
      matcher = "fuzzy",
      symbolMatcher = "fuzzy",
      analyses = {
        printf = true,
        fillreturns = true,
        nonewvars = true,
        undeclaredname = true,
        unusedparams = true,
        unreachable = true,
        fieldalignment = true,
        ifaceassert = true,
        nilness = true,
        shadow = true,
        unusedwrite = true,
        fillstruct = true,
      },
      annotations = {
        escape = true,
        inline = true,
        bounds = true,
      },
      deepCompletion = true,
      tempModfile = false,
      expandWorkspaceToModule = false,
      verboseOutput = true,
      gofumpt = true,
      directoryFilters = {
        "-node_modules",
        "-third_party",
      },
    },
  },
}

lspconfig.golangci_lint_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Javascript & Typescript LSP
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- HTML/CSS LSP
-- npm i -g vscode-langservers-extracted
lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- npm i -g vscode-langservers-extracted
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- npm i -g vscode-langservers-extracted
lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
