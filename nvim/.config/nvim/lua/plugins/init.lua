local ok, packer = pcall(require, 'packer')
if not ok then
  return
end

local use = packer.use

return packer.startup({
  function()
    -- Packer himself
    use('wbthomason/packer.nvim')

    -- Better performance for Neovim
    use('lewis6991/impatient.nvim')
    use('nathom/filetype.nvim')
    use('antoinemadec/FixCursorHold.nvim')

    -- Make Neovim look good
    use('kyazdani42/nvim-web-devicons')
    use('tomasiser/vim-code-dark')
    use({
      'feline-nvim/feline.nvim',
      config = function()
        require('plugins.configs.feline').setup()
      end,
    })

    -- Lsp and friends
    use({
      'neoclide/coc.nvim',
      branch = 'release',
      config = function()
        require('plugins.configs.coc').setup()
      end,
    })

    -- Snippet
    use('rafamadriz/friendly-snippets')

    -- Fuzzy finder
    use({
      'ibhagwan/fzf-lua',
      cmd = { 'FzfLua' },
      config = function()
        require('plugins.configs.fzf-lua').setup()
      end,
    })

    -- Terminal
    use({
      'voldikss/vim-floaterm',
      cmd = {
        'FloatermNew',
        'FloatermPrev',
        'FloatermNext',
        'FloatermToggle',
        'FloatermHide',
        'FloatermKill',
        'FloatermShow',
      },
      config = function()
        require('plugins.configs.floaterm').setup()
      end,
    })

    -- Git
    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('plugins.configs.gitsigns').setup()
      end,
    })
    use('tpope/vim-fugitive')

    -- Commenting code
    use({
      'numToStr/Comment.nvim',
      after = 'nvim-ts-context-commentstring',
      config = function()
        require('plugins.configs.comment').setup()
      end,
    })

    -- Syntax highlighting (and more)
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('plugins.configs.treesitter').setup_ts()
      end,
    })
    use('sheerun/vim-polyglot')

    -- Set the comment string based on the cursor location in a file
    use({
      'JoosepAlviste/nvim-ts-context-commentstring',
      requires = 'nvim-treesitter/nvim-treesitter',
      after = 'nvim-treesitter',
      config = function()
        require('plugins.configs.treesitter').setup_context_commentstring()
      end,
    })

    -- Use treesitter to auto close and auto rename HTML tags
    use({
      'windwp/nvim-ts-autotag',
      requires = 'nvim-treesitter/nvim-treesitter',
      after = 'nvim-treesitter',
      config = function()
        require('plugins.configs.treesitter').setup_autotag()
      end,
    })

    -- Show code context
    use({
      'nvim-treesitter/nvim-treesitter-context',
      requires = 'nvim-treesitter/nvim-treesitter',
      after = 'nvim-treesitter',
    })

    -- Autopairs
    use({
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('plugins.configs.autopairs').setup()
      end,
    })

    -- Text objects for entire buffer
    use({
      'kana/vim-textobj-entire',
      requires = 'kana/vim-textobj-user',
    })

    -- Indent guides for Neovim
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('plugins.configs.indent-blankline').setup()
      end,
    })

    -- Surround
    use({
      'machakann/vim-sandwich',
      config = function()
        vim.cmd('runtime macros/sandwich/keymap/surround.vim')
      end,
    })

    -- Make the yanked region apparent
    use({
      'machakann/vim-highlightedyank',
      config = function()
        require('plugins.configs.highlightedyank').setup()
      end,
    })

    -- Easy motions / navigations
    use({
      'mrjones2014/smart-splits.nvim',
      module = 'smart-splits',
    })
    use({
      'https://gitlab.com/yorickpeterse/nvim-window.git',
      module = 'nvim-window',
      config = function()
        require('plugins.configs.window').setup()
      end,
    })
    use({
      'christoomey/vim-tmux-navigator',
      config = function()
        require('plugins.configs.tmux').setup()
      end,
    })
    use({
      'teranex/jk-jumps.vim',
      config = function()
        vim.g.jk_jumps_minimum_lines = 2
      end,
    })

    -- Buffers management
    use({
      'Asheq/close-buffers.vim',
      cmd = { 'Bdelete', 'Bwipeout' },
    })

    -- Markdown
    use({ 'ellisonleao/glow.nvim', ft = { 'markdown' } })
    use({ 'davidgranstrom/nvim-markdown-preview', ft = { 'markdown' } })

    -- Move lines and selections
    use('matze/vim-move')

    -- Trailing whitespaces
    use('ntpeters/vim-better-whitespace')

    -- Sessions
    use({
      'rmagatti/auto-session',
      config = function()
        require('plugins.configs.session').setup()
      end,
    })

    -- Startup time
    use({
      'dstein64/vim-startuptime',
      cmd = { 'StartupTime' },
    })

    -- Colors related stuff
    use({
      'rrethy/vim-hexokinase',
      run = 'make hexokinase',
      config = function()
        require('plugins.configs.hexokinase').setup()
      end,
    })

    -- Miscs
    use({ 'lambdalisue/suda.vim' })
  end,
  config = {
    compile_path = vim.fn.stdpath('config') .. '/lua/plugins/packer_compiled.lua',
    auto_clean = true,
    compile_on_sync = true,
  },
})
