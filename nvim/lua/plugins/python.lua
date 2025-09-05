return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 🚫 Desactiva Pyright explícitamente
        pyright = false,

        -- ✅ Mantén Pylsp
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
                pyflakes = { enabled = false },
                black = { enabled = true },
                isort = { enabled = true },
                pylsp_mypy = { enabled = true, live_mode = false },
              },
            },
          },
        },

        -- ✅ Ruff LSP para linting
        ruff_lsp = {},
      },
    },
  },

  -- Configuración de formateo
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black", "isort" },
        lua = { "stylua" },
        javascript = { "prettier" },
      },
    },
  },
}
