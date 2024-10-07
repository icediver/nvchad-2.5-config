local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
  },

  formatters = {
    prettierd = {
      prepend_args = {
        "--single-attribute-per-line",
        "--no-bracket-same-line",
      },
    },
  },

  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_format = "fallback",
    -- timeout_ms = 500,
  },
  log_level = vim.log.levels.DEBUG,
}

require("conform").setup(options)
