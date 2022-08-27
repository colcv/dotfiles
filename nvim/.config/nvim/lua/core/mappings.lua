local M = {}
local map = require('core.utils').map

local configs = {
  -- coc.nvim
  coc = function()
    -- coc-explorer
    map('n', '<C-n>', [[<CMD>CocCommand explorer<CR><CMD>sleep 20m<CR><C-w>=]])

    -- coc-snippet
    vim.g.coc_snippet_next = '<Tab>'
    vim.g.coc_snippet_prev = '<S-Tab>'

    -- Use <C-space> to trigger completion
    map('i', '<C-space>', function()
      return vim.fn['coc#refresh']()
    end, { expr = true })

    -- Make <CR> auto-select the first completion item and notify coc.nvim to ...
    -- ... format on enter, <CR> could be remapped by other vim plugin
    _G.CR = function()
      local _, autopairs = pcall(require, 'nvim-autopairs')
      if vim.fn['coc#pum#visible']() ~= 0 then
        return vim.fn['coc#pum#confirm']()
      else
        return autopairs.autopairs_cr()
      end
    end
    map('i', '<CR>', 'v:lua.CR()', { expr = true })

    -- Use <C-j> and <C-k> to navigate the completion list
    map('i', '<C-j>', "coc#pum#visible() ? coc#pum#next(1) : '<C-j>'", { expr = true })
    map('i', '<C-k>', "coc#pum#visible() ? coc#pum#prev(1) : '<C-k>'", { expr = true })

    -- Use `[d` and `]d` to navigate diagnostics
    map('n', '[d', '<Plug>(coc-diagnostic-prev)')
    map('n', ']d', '<Plug>(coc-diagnostic-next)')

    -- GOTO code navigation
    map('n', 'gd', '<Plug>(coc-definition)')
    map('n', 'gy', '<Plug>(coc-type-definition)')
    map('n', 'gi', '<Plug>(coc-implementation)')
    map('n', 'gr', '<Plug>(coc-references)')

    -- Use gh to show documentation in preview window
    map('n', 'gh', function()
      if vim.fn.CocAction('hasProvider', 'hover') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.fn.feedkeys('gh', 'in')
      end
    end)

    -- Symbol renaming
    map('n', 'gn', '<Plug>(coc-rename)')

    -- Formatting selected code
    map({ 'x', 'n' }, 'gf', '<Plug>(coc-format-selected)')

    -- Applying code action to the selected region
    map({ 'x', 'n' }, 'ga', '<Plug>(coc-codeaction-selected)')

    -- Applying code action to the current buffer
    map('n', 'gA', '<Plug>(coc-codeaction)')

    -- Apply autofix to problem on the current line
    map('n', 'gF', '<Plug>(coc-fix-current)')

    -- Run the Code Lens action on the current line
    map('n', 'gl', '<Plug>(coc-codelens-action)')

    -- Map function and class text objects
    -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
    map({ 'x', 'o' }, 'if', '<Plug>(coc-funcobj-i)')
    map({ 'x', 'o' }, 'af', '<Plug>(coc-funcobj-a)')
    map({ 'x', 'o' }, 'ic', '<Plug>(coc-classobj-i)')
    map({ 'x', 'o' }, 'ac', '<Plug>(coc-classobj-a)')

    -- Remap <C-e> and <C-y> for scroll float windows/popups
    map({ 'n', 'v' }, '<C-e>', "coc#float#has_scroll() ? coc#float#scroll(1) : '<C-e>'", { expr = true, nowait = true })
    map({ 'n', 'v' }, '<C-y>', "coc#float#has_scroll() ? coc#float#scroll(0) : '<C-y>'", { expr = true, nowait = true })
    map('i', '<C-e>', "coc#float#has_scroll() ? '<C-r>=coc#float#scroll(1)<cr>' : '<C-e>'", {
      expr = true,
      nowait = true,
    })
    map('i', '<C-y>', "coc#float#has_scroll() ? '<C-r>=coc#float#scroll(0)<cr>' : '<C-y>'", {
      expr = true,
      nowait = true,
    })

    -- Use ctrl-s for selections ranges
    map({ 'n', 'x' }, '<C-s>', '<Plug>(coc-range-select)')

    -- Mappings for CoCList
    map('n', '<M-o>L', '<CMD>CocList<CR>', { nowait = true })
    map('n', '<M-o>c', '<CMD>CocList commands<CR>', { nowait = true })
    map('n', '<M-o>e', '<CMD>CocList extensions<CR>', { nowait = true })
    map('n', '<M-o>d', '<CMD>CocList -A diagnostics<CR>', { nowait = true })
    map('n', '<M-o>l', '<CMD>CocList -A location<CR>', { nowait = true })
    map('n', '<M-o>s', '<CMD>CocList -A -I symbols<CR>', { nowait = true })
    map('n', '<M-o>o', '<CMD>CocList -A outline<CR>', { nowait = true })

    local toggleOutline = function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if buf_ft == 'coctree' then
          vim.fn.CocAction('hideOutline')
          return
        end
      end
      vim.fn.CocAction('showOutline')
    end
    map('n', '<M-o>t', toggleOutline, { nowait = true })
  end,

  -- vim-floaterm
  floaterm = function()
    map('n', '<C-q>c', [[<CMD>FloatermNew<CR>]])
    map('t', '<C-q>c', [[<C-\><C-n><cmd>FloatermNew<CR>]])
    map('n', '<C-q>p', [[<cmd>FloatermPrev<CR>]])
    map('t', '<C-q>p', [[<C-\><C-n><CMD>FloatermPrev<CR>]])
    map('n', '<C-q>n', [[<CMD>FloatermNext<CR>]])
    map('t', '<C-q>n', [[<C-\><C-n><CMD>FloatermNext<CR>]])
    map('n', '<C-q>t', [[<CMD>FloatermToggle<CR>]])
    map('t', '<C-q>t', [[<C-\><C-n><CMD>FloatermToggle<CR>]])
    map('n', '<C-q>h', [[<CMD>FloatermHide!<CR>]])
    map('t', '<C-q>h', [[<C-\><C-n><CMD>FloatermHide!<CR>]])
    map('n', '<C-q>k', [[<CMD>FloatermKill<CR><CMD>FloatermShow!<CR>]])
    map('t', '<C-q>k', [[<C-\><C-n><CMD>FloatermKill<CR><CMD>FloatermShow!<CR>]])
    map('t', '<C-h>', [[<C-\><C-n><C-w>h]])

    -- Clear terminal (Only work for floaterm)
    map('t', '<C-l>', function()
      if vim.bo.filetype == 'floaterm' then
        return [[<C-\><C-n><CMD>set scrollback=1<CR><CMD>sleep 10ms<CR><CMD>set scrollback=10000<CR>i<C-l><C-\><C-n><CMD>FloatermHide<CR><CMD>FloatermShow<CR><C-l>]]
      end
      return [[<C-\><C-n><C-w>l]]
    end, { expr = true })
  end,

  -- nvim-window
  nvim_window = function()
    map('n', '<space>w', function()
      require('nvim-window').pick()
    end)
  end,

  -- smart-splits.nvim
  smart_splits = function()
    -- Resizing splits
    map('n', '<A-H>', function()
      require('smart-splits').resize_left()
    end)
    map('n', '<A-J>', function()
      require('smart-splits').resize_down()
    end)
    map('n', '<A-K>', function()
      require('smart-splits').resize_up()
    end)
    map('n', '<A-L>', function()
      require('smart-splits').resize_right()
    end)
  end,

  -- fzf-lua
  fzf_lua = function()
    map('n', '<C-p>p', [[<CMD>FzfLua builtin<CR>]])
    map('n', '<C-p>f', [[<CMD>FzfLua files<CR>]])
    map('n', '<C-p>b', [[<CMD>FzfLua buffers<CR>]])
    map('n', '<C-p>r', [[<CMD>FzfLua live_grep_native<CR>]])
    map('n', '<C-p>h', [[<CMD>FzfLua help_tags<CR>]])
  end,
}

M.init = function()
  -- Better indenting in visual mode
  map('v', '<', '<gv')
  map('v', '>', '>gv')

  -- Make <C-w> work as expected in prompt window
  -- map('i', '<C-W>', '<C-S-W>')

  -- Better movement between wrapped lines
  map('n', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
  map('n', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

  -- Don't copy the replaced text after pasting in visual mode
  map('v', 'p', '"_dP')

  -- Load plugins mappings
  for _, config in pairs(configs) do
    config()
  end
end

return M
