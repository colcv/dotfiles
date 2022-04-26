local utils = require "core.utils"
local map = utils.map

-- coc-explorer
map("n", "<C-n>", "<cmd>CocCommand explorer<cr><cmd>sleep 50ms<cr><C-w>=")

-- coc-snippet
vim.g.coc_snippet_next = "<Tab>"
vim.g.coc_snippet_prev = "<S-Tab>"

-- Use <C-space> to trigger completion
map("i", "<C-space>", "coc#refresh()", { expr = true })

-- Use <C-j> and <C-k> to navigate the completion list
map("i", "<C-j>", 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true })
map("i", "<C-k>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true })

-- Use `[g` and `]g` to navigate diagnostics
map("n", "[d", "<Plug>(coc-diagnostic-prev)")
map("n", "]d", "<Plug>(coc-diagnostic-next)")

-- GOTO code navigation (Use telescope-coc.nvim)
-- map("n", "gd", "<Plug>(coc-definition)")
-- map("n", "gy", "<Plug>(coc-type-definition)")
-- map("n", "gi", "<Plug>(coc-implementation)")
-- map("n", "gr", "<Plug>(coc-references)")
map("n", "gd", "<cmd>Telescope coc definitions<cr>")
map("n", "gy", "<cmd>Telescope coc type_definitions<cr>")
map("n", "gi", "<cmd>Telescope coc implementations<cr>")
map("n", "gr", "<cmd>Telescope coc references<cr>")

-- Use gh to show documentation in preview window
map("n", "gh", function()
  local cw = vim.fn.expand "<cword>"
  if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
    vim.cmd("h " .. cw)
  elseif vim.api.nvim_eval "coc#rpc#ready()" then
    vim.fn.CocActionAsync "doHover"
  else
    vim.cmd("!" .. vim.o.keywordprg .. " " .. cw)
  end
end)

-- Symbol renaming
map("n", "<space>rn", "<Plug>(coc-rename)")

-- Formatting selected code
map({ "x", "n" }, "<space>fm", "<Plug>(coc-format-selected)")

-- Applying code action to the selected region
map({ "x", "n" }, "<space>a", "<Plug>(coc-codeaction-selected)")

-- Applying code action to the current buffer
map("n", "<space>A", "<Plug>(coc-codeaction)")

-- Apply autofix to problem on the current line
map("n", "<space>qf", "<Plug>(coc-fix-current)")

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
map({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)")
map({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)")
map({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)")
map({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)")

-- Remap <C-f> and <C-b> for scroll float windows/popups
map({ "n", "v" }, "<C-f>", "coc#float#has_scroll() ? coc#float#scroll(1) : '<C-d>'", { expr = true, nowait = true })
map({ "n", "v" }, "<C-b>", "coc#float#has_scroll() ? coc#float#scroll(0) : '<C-u>'", { expr = true, nowait = true })
map(
  "i",
  "<C-f>",
  "coc#float#has_scroll() ? '<C-r>=coc#float#scroll(1)<cr>' : '<Right>'",
  { expr = true, nowait = true }
)
map("i", "<C-b>", "coc#float#has_scroll() ? '<C-r>=coc#float#scroll(0)<cr>' : '<Left>'", {
  expr = true,
  nowait = true,
})

-- Use ctrl-s for selections ranges
map({ "n", "x" }, "<C-s>", "<Plug>(coc-range-select)")

-- Mappings for CoCList
map("n", "<space>e", "<cmd>CocList extensions<cr>")
map("n", "<space><space>", "<cmd>Telescope coc coc<cr>")
map("n", "<space>D", "<cmd>Telescope coc workspace_diagnostics<cr>")
map("n", "<space>d", "<cmd>Telescope coc diagnostics<cr>")
map("n", "<space>c", "<cmd>Telescope coc commands<cr>")
map("n", "<space>l", "<cmd>Telescope coc locations<cr>")
map("n", "<space>s", "<cmd>Telescope coc document_symbols<cr>")
-- map("n", "<space>o", "<cmd>CocList outline<cr>")
-- map("n", "<space>p", "<cmd>CocListResume<cr>")

-- Make <CR> auto-select the first completion item and notify coc.nvim to ...
-- ... format on enter, <CR> could be remapped by other vim plugin
_G.CR = function()
  local _, autopairs = pcall(require, "nvim-autopairs")
  if vim.fn.pumvisible() ~= 0 then
    return vim.fn["coc#_select_confirm"]()
  else
    return autopairs.autopairs_cr()
  end
end
map("i", "<cr>", "v:lua.CR()", { expr = true })
