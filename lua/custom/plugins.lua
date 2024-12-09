local plugins = {
  {
    "garymjr/nvim-snippets",
    keys = {
      {
        "<Tab>",
        function()
          if vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
            return
          end
          return "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<Tab>",
        function()
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        end,
        expr = true,
        silent = true,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          if vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
            return
          end
          return "<S-Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.summary"] = {},
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp"
            }
          },
        }
      }
      vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = {"*.norg"},
        command = "set conceallevel=3"
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "html",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function ()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    ft = {"python"}, opts = function ()
      return require "custom.configs.null-ls"
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "tailwindcss-language-server",
        "black",
        "prettierd",
        "debugpy",
        "eslint-lsp",
        "mypy",
        "ruff",
        "pyright",
        "typescript-language-server",
        "jdtls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
      }
      return opts
    end
  },
   {
    "mbbill/undotree",
    lazy = false,
    config = function()
       -- Optional: Define keybindings or configuration
    --
       vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { noremap = true, silent = true })
    end,
   },
  {
    "styled-components/vim-styled-components",
    branch = "main",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
}

return plugins
