return {
  -- Molten.nvim: Cell execution and kernel management
  {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true
      vim.g.molten_tick_rate = 142
      vim.g.molten_log_file = "/home/alejo/molten.log"
      vim.g.molten_log_level = "debug"
    end,
    keys = {
      { "<leader>mi", ":MoltenInit<cr>", desc = "Molten Init" },
      { "<leader>rh", ":MoltenHideOutput<cr>", desc = "Molten Hide Output" },
      { "<leader>rd", ":MoltenDelete<cr>", desc = "Molten Delete" },
    },
  },

  -- Quarto-nvim: UI for cells, LSP support (via otter.nvim), and keybindings
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown", "python" },
    opts = {
      lsp_features = {
        languages = { "python", "r", "julia", "bash" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    keys = {
      { "<leader>re", ":QuartoRun<cr>", desc = "Run Cell" },
      { "<leader>ra", ":QuartoRunAll<cr>", desc = "Run All Cells" },
    },
  },

  -- Otter.nvim: LSP for embedded code chunks
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },

  -- Jupytext: Open .ipynb files as Markdown or Python
  {
    "goerz/jupytext.vim",
    init = function()
      vim.g.jupytext_fmt = "py:percent"
      vim.g.jupytext_filetype_map = {
        ipynb = "python",
      }
    end,
  },
}
