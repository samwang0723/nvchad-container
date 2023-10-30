local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        cargo = {
          target = "x86_64-unknown-linux-musl",
        },
        check = {
          target = "x86_64-unknown-linux-musl",
        },
        -- enable clippy on save
        checkOnSave = {
          targets = "x86_64-unknown-linux-musl",
          command = "clippy",
        },
      },
    },
  },
  -- debugging stuff
  dap = {
    adapter = {
      type = "executable",
      command = "lldb",
      name = "rt_lldb",
    },
  },
}

return options
