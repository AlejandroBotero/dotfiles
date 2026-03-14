return {
  -- Configuración de Markdown Preview (Navegador)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
      { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", ft = "markdown" },
    },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      -- Forzar apertura en nueva ventana usando Brave
      vim.g.mkdp_command_for_browser = "brave --new-window"
      vim.g.mkdp_browser = "" 
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
      }
    end,
  },

  -- Configuración de Renderizado en el editor
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      latex = {
        enabled = true,
        render_method = "nabla",
      },
      anti_conceal = {
        enabled = false,
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      -- Force conceallevel for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.conceallevel = 2
        end,
      })
    end,
  },

  -- Configuración de Nabla (Popup)
  {
    "jbyuki/nabla.nvim",
    keys = {
      {
        "<leader>cl",
        function()
          require("nabla").popup()
        end,
        desc = "LaTeX Popup",
      },
    },
  },

  -- Asegurar que los parsers necesarios estén instalados
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "latex", "markdown_inline" })
      end
    end,
  },
}
