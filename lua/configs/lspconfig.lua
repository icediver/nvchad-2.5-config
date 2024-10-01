local configs = require "nvchad.configs.lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "clangd",
  "gopls",
  "gradle_ls",
  "tailwindcss",
  "prismals",
  "emmet_language_server",
  "jsonls",
  "ts_ls",
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports",
      },
    },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  }

  lspconfig.ts_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      typescriptreact = {
        lint = {

          --
        },
      },
    },
  }

  lspconfig.prismals.setup {}
  lspconfig.cssls.setup {
    settings = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  }
  lspconfig.jsonls.setup {}
  lspconfig.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "css", "scss", "html" },
    settings = {
      emmetCompletions = true,
      tailwindCSS = {
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning",
        },
      },
    },
  }
  lspconfig.volar.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  }
  lspconfig.emmet_language_server.setup {
    filetypes = {
      "css",
      "eruby",
      "html",
      "javascript",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "pug",
      "typescriptreact",
    },
    -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
    -- **Note:** only the options listed in the table are supported.
    init_options = {
      ---@type table<string, string>
      includeLanguages = {
        -- javascript = "javascriptreact",
        -- javascriptreact = "jsx",
        -- typescriptreact = "css",
      },
      --- @type string[]
      excludeLanguages = {},
      --- @type string[]
      extensionsPath = {
        vim.fn.stdpath "config" .. "/emmet",
      },
      --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
      preferences = {},
      --- @type boolean Defaults to `true`
      showAbbreviationSuggestions = true,
      --- @type "always" | "never" Defaults to `"always"`
      showExpandedAbbreviation = "always",
      --- @type boolean Defaults to `false`
      showSuggestionsAsSnippets = false,
      --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
      syntaxProfiles = {},
      --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
      variables = {},
    },
  }
  -- lspconfig.emmet_ls.setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   filetypes = {
  --     "css",
  --     "eruby",
  --     "html",
  --     "javascript",
  --     "javascriptreact",
  --     "less",
  --     "sass",
  --     "scss",
  --     "svelte",
  --     "pug",
  --     "typescriptreact",
  --     "vue",
  --   },
  --   init_options = {
  --     html = {
  --       options = {
  --         -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
  --         -- ["output.selfClosingStyle"] = "xhtml",
  --         ["bem.enabled"] = true,
  --       },
  --     },
  --   },
  -- }
end
