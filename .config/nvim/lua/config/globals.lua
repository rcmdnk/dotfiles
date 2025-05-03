-- Set <space> as the leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Disable clipboard integration
-- To fix this issue, need COLORTERM=truecolor in bash env and this setting in nvim
-- [DECRQSS +q5463;524742;73657472676266;73657472676262$qm appears in terminal · Issue #28776 · neovim/neovim](https://github.com/neovim/neovim/issues/28776)

-- Need this for v0.10
vim.g.clipboard = false

-- Need this for after [feat(clipboard)!: use OSC 52 as fallback clipboard provider by gpanders · Pull Request #31730 · neovim/neovim](https://github.com/neovim/neovim/pull/31730) is merged (v0.11 and later)
local termfeatures = vim.g.termfeatures or {}
termfeatures.osc52 = false
vim.g.termfeatures = termfeatures


-- Fix python indentation
vim.g.python_indent = {
  closed_paren_align_last_line = false,
  open_paren = 'shiftwidth()',
}
