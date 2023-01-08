local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd({ cmd = 'packadd', args = { 'packer.nvim' } })
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local ok, packer = pcall(require, 'packer')
if not ok then
  return
end

return packer.startup({
  function(use)
    -- Packer himself
    use('wbthomason/packer.nvim')

    -- Better performance for Neovim
    use('lewis6991/impatient.nvim')

    -- UI stuff
    use('Mofiqul/vscode.nvim')
    -- use('projekt0n/github-nvim-theme')
    -- use('rebelot/kanagawa.nvim')
    use('kyazdani42/nvim-web-devicons')
    use({
      'feline-nvim/feline.nvim',
      config = function()
        require('plugins.configs.feline').setup()
      end,
    })

    -- Sessions
    use({
      'rmagatti/auto-session',
      config = function()
        require('plugins.configs.session').setup()
      end,
    })

    -- LSP and friends
    use({
      'neoclide/coc.nvim',
      branch = 'release',
      config = function()
        require('plugins.configs.coc').setup()
      end,
    })
    use('xiyaowong/coc-symbol-line')

    -- Languages
    use('tpope/vim-rails')

    -- Snippet
    use({ 'honza/vim-snippets' })
    use({
      'SirVer/ultisnips',
      config = function()
        vim.g.UltiSnipsExpandTrigger = '<Tab>'
        vim.g.UltiSnipsJumpForwardTrigger = '<C-f>'
        vim.g.UltiSnipsJumpBackwardTrigger = '<C-b>'
      end,
    })

    -- Document generator
    use({
      'kkoomen/vim-doge',
      run = ':call doge#install()',
      config = function()
        vim.g.doge_javascript_settings = {
          destructuring_props = 1,
          omit_redundant_param_types = 1,
        }
      end,
    })

    -- Fuzzy finder
    use({
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.configs.telescope').setup()
      end,
    })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    use('nvim-telescope/telescope-media-files.nvim')
    use('fannheyward/telescope-coc.nvim')

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
        vim.g.floaterm_wintype = 'float'
        vim.g.floaterm_position = 'topright'
        vim.g.floaterm_title = ' TERMINAL: $1/$2 '
        vim.g.floaterm_width = 0.5
        vim.g.floaterm_height = 0.99
      end,
    })

    -- Git
    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('plugins.configs.gitsigns').setup()
      end,
    })
    use({
      'kdheepak/lazygit.nvim',
      config = function()
        vim.g.lazygit_floating_window_winblend = 10
        vim.g.lazygit_floating_window_scaling_factor = 0.88
        vim.g.lazygit_floating_window_corner_chars = { '┌', '┐', '└', '┘' }
        vim.g.lazygit_floating_window_use_plenary = 0
      end,
    })

    -- Commenting code
    use({
      'numToStr/Comment.nvim',
      after = 'nvim-ts-context-commentstring',
      keys = { 'gc', 'gb' },
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

    -- Syntax aware text-objects
    use({
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = 'nvim-treesitter/nvim-treesitter',
      after = 'nvim-treesitter',
      config = function()
        require('plugins.configs.treesitter').setup_textobjects()
      end,
    })

    -- Show code context
    -- use({
    --   'nvim-treesitter/nvim-treesitter-context',
    --   requires = 'nvim-treesitter/nvim-treesitter',
    --   after = 'nvim-treesitter',
    -- })

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
        vim.cmd({ cmd = 'runtime', args = { 'macros/sandwich/keymap/surround.vim' } })
      end,
    })

    -- Make yank better
    use({
      'machakann/vim-highlightedyank',
      config = function()
        vim.g.highlightedyank_highlight_duration = 300
      end,
    })
    use('svban/YankAssassin.vim')

    -- Windows / Split
    use({
      'simeji/winresizer',
      config = function()
        vim.g.winresizer_start_key = '<leader>m'
      end,
    })
    use({
      'https://gitlab.com/yorickpeterse/nvim-window.git',
      module = 'nvim-window',
      config = function()
        require('plugins.configs.window').setup()
      end,
    })

    -- Tmux
    use({
      'christoomey/vim-tmux-navigator',
      config = function()
        vim.g.tmux_navigator_disable_when_zoomed = 1
      end,
    })

    -- Buffers
    use({
      'kazhala/close-buffers.nvim',
      module = 'close_buffers',
      config = function()
        require('plugins.configs.close-buffers').setup()
      end,
    })

    -- Markdown
    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
      ft = { 'markdown' },
    })

    -- Trailing whitespaces
    use({
      'ntpeters/vim-better-whitespace',
      config = function()
        vim.g.better_whitespace_filetypes_blacklist = {
          'toggleterm',
          'diff',
          'git',
          'gitcommit',
          'unite',
          'qf',
          'help',
          'markdown',
          'fugitive',
        }
      end,
    })

    -- Colors related stuff
    use({
      'brenoprata10/nvim-highlight-colors',
      config = function()
        require('nvim-highlight-colors').setup({
          render = 'background',
          enable_named_color = true,
          enable_tailwind = true,
        })
      end,
    })

    -- Utils
    use('matze/vim-move')
    use({
      'dstein64/vim-startuptime',
      cmd = { 'StartupTime' },
    })
    use({
      'lambdalisue/suda.vim',
      cmd = { 'SudaRead', 'SudaWrite' },
    })
    use({
      'declancm/cinnamon.nvim',
      config = function()
        require('cinnamon').setup({
          always_scroll = true,
          centered = true,
          default_delay = 2,
        })
      end,
    })
    -- use({
    --   'anuvyklack/pretty-fold.nvim',
    --   config = function()
    --     require('plugins.configs.pretty-fold').setup()
    --   end,
    -- })
    -- use({
    --   'anuvyklack/fold-preview.nvim',
    --   requires = 'anuvyklack/keymap-amend.nvim',
    --   config = function()
    --     require('fold-preview').setup()
    --   end,
    -- })
    use('gcmt/taboo.vim')
    use('jeffkreeftmeijer/vim-numbertoggle')
    use({
      'abecodes/tabout.nvim',
      config = function()
        require('tabout').setup()
      end,
    })
    use('tpope/vim-sleuth')
    use('tpope/vim-unimpaired')

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    compile_path = vim.fn.stdpath('config') .. '/lua/plugins/packer_compiled.lua',
    auto_clean = true,
    compile_on_sync = true,
  },
})
