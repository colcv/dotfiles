local fzf_map_prefix = "<leader>f"

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = {
      winopts = {
        border = "single",
        preview = {
          vertical = "down:45%",
          horizontal = "right:55%",
        },
      },
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
    keys = {
      { fzf_map_prefix .. "p", [[<CMD>FzfLua builtin<CR>]] },
      { fzf_map_prefix .. "f", [[<CMD>FzfLua files<CR>]] },
      { fzf_map_prefix .. "b", [[<CMD>FzfLua buffers<CR>]] },
      { fzf_map_prefix .. "r", [[<CMD>FzfLua live_grep<CR>]] },
      { fzf_map_prefix .. "h", [[<CMD>FzfLua helptags<CR>]] },
      { fzf_map_prefix .. "q", [[<CMD>FzfLua quickfix<CR>]] },
    },
  },
}
