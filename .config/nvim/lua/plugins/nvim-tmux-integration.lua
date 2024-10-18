return {
    "christoomey/vim-tmux-navigator",
    vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>", { desc = "TMUX: Go to left pane" }),
    vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>", { desc = "TMUX: Go to bottom pane" }),
    vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>", { desc = "TMUX: Go to right pane" }),
    vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>", { desc = "TMUX: Got to upper pane" }),
}
