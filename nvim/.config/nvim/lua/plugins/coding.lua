return {
  -- Time Pope stuff
  { "tpope/vim-sleuth" }, -- Heuristically set buffer options
  { "tpope/vim-abolish", event = "VeryLazy" }, -- Work with several variants of a word at once
  { "tpope/vim-unimpaired", event = "VeryLazy" }, -- Pairs of handy bracket mappings
  { "tpope/vim-eunuch", event = "VeryLazy" }, -- Helpers for UNIX
  { "tpope/vim-rails" }, --  Ruby on Rails power tools
  -- { "tpope/vim-haml", ft = { "haml" } },

  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    opts = {
      panel = {
        auto_refresh = true,
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          -- accept_word = "<C-l>w",
          -- accept_line = "<C-l>l",
        },
      },
      filetypes = {},
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- { "craigemery/vim-autotag", event = "VeryLazy" },

  -- ansible
  -- { "pearofducks/ansible-vim" },

  -- preview markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- generate code documentation
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    event = "VeryLazy",
    init = function()
      vim.g.doge_javascript_settings = {
        destructuring_props = 1,
        omit_redundant_param_types = 1,
      }
    end,
  },

  -- surround
  {
    "https://github.com/machakann/vim-sandwich",
    event = "VeryLazy",
    init = function()
      vim.g.sandwich_no_default_key_mappings = 1
      vim.g.operator_sandwich_no_default_key_mappings = 1
      vim.g.textobj_sandwich_no_default_key_mappings = 1
    end,
    config = function()
      vim.cmd("runtime macros/sandwich/keymap/surround.vim")
    end,
  },

  -- smart splitting/joining code
  {
    "Wansmer/treesj",
    event = "VeryLazy",
    keys = { { "<leader>j", [[<cmd>TSJToggle<cr>]] } },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false, max_join_length = 9999 },
    config = function(_, opts)
      require("treesj").setup(opts)
    end,
  },

  -- notes
  {
    "backdround/global-note.nvim",
    config = true,
    cmd = "GlobalNote",
  },
}
