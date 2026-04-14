-- Set <space> as the leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Disable clipboard integration
-- To fix this issue, need COLORTERM=truecolor in bash env and this setting in nvim
-- [DECRQSS +q5463;524742;73657472676266;73657472676262$qm appears in terminal · Issue #28776 · neovim/neovim](https://github.com/neovim/neovim/issues/28776)

if vim.fn.has("nvim-0.11.0") == 1 then
  -- Need this for after [feat(clipboard)!: use OSC 52 as fallback clipboard provider by gpanders · Pull Request #31730 · neovim/neovim](https://github.com/neovim/neovim/pull/31730) is merged (v0.11 and later)
  local termfeatures = vim.g.termfeatures or {}
  termfeatures.osc52 = false
  vim.g.termfeatures = termfeatures
else
  -- Need this for v0.10
  vim.g.clipboard = false
end

-- Suppress client.is_stopped dot-syntax deprecation warning (nvim 0.12+)
-- Plugins (copilot-cmp, nvim-lspconfig) call client.is_stopped() with dot
-- syntax which triggers a deprecation warning. Suppress until plugins update.
if vim.fn.has('nvim-0.12') == 1 then
  local orig_deprecate = vim.deprecate
  vim.deprecate = function(old, new, version, ...)
    if old == 'client.is_stopped' then
      return
    end
    return orig_deprecate(old, new, version, ...)
  end
end

-- Fix python indentation
vim.g.python_indent = {
  closed_paren_align_last_line = false,
  open_paren = 'shiftwidth()',
}
