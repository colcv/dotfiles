local M = {}

M.setup = function()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    return
  end

  -- Loading extensions
  local extensions = { "fzf", "media_files" }
  for _, ext in ipairs(extensions) do
    telescope.load_extension(ext)
  end

  local actions = require "telescope.actions"

  telescope.setup {
    defaults = {
      layout_strategy = "vertical",
      layout_config = {
        height = 0.95,
        -- width = 120,
        prompt_position = "bottom",
        preview_height = 0.4,
        preview_cutoff = 0,
        mirror = false,
        scroll_speed = 1,
      },
      vimgrep_arguments = {
        "rg",
        "--column",
        "--line-number",
        "--no-heading",
        "--color=always",
        "--smart-case",
        "--hidden",
        "--with-filename",
        "--glob=!.git/",
      },
      file_ignore_patterns = {
        "node_modules",
        "^./.git/",
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<M-c>"] = actions.close,
          ["<M-w>"] = actions.delete_buffer,
          ["<C-y>"] = actions.preview_scrolling_up,
          ["<C-e>"] = actions.preview_scrolling_down,
          -- ["<esc>"] = actions.close,
        },
      },
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
    extensions = {
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg", "webm", "pdf", "mp4" },
      },
    },
  }
end

return M
