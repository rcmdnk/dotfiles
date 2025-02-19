-- format.lua

-- Indent all lines in the buffer
local function indent_all()
  local cursor_pos = vim.fn.getcurpos()
  vim.cmd('keepjumps normal! gg=G')
  vim.fn.setpos('.', cursor_pos)
end

-- Delete trailing whitespace in the entire buffer
local function delete_space()
  vim.cmd([[%s/\s\+$//e]])
end

-- Delete trailing whitespace in the selected region
local function delete_space_visual()
  vim.cmd([['<,'>s/\s\+$//e]])
end

-- Align code: retab, indent all, and remove trailing spaces
local function align_code()
  vim.cmd('retab')
  indent_all()
  delete_space()
end

-- Align all buffers
local function align_all_buf()
  local current_buf = vim.fn.bufnr('%')
  for i = 1, vim.fn.bufnr('$') do
    if vim.fn.buflisted(i) == 1 then
      vim.cmd('buffer ' .. i)
      align_code()
      vim.cmd('update')
    end
  end
  vim.cmd('buffer ' .. current_buf)
end

-- Create commands
vim.api.nvim_create_user_command('IndentAll', indent_all, {})
vim.api.nvim_create_user_command('DeleteSpace', delete_space, {})
vim.api.nvim_create_user_command('AlignCode', align_code, {})
vim.api.nvim_create_user_command('AlignAllBuf', align_all_buf, {})

-- Create keymaps
vim.keymap.set('n', '<Leader><Space>', ':DeleteSpace<CR>', { silent = true })
vim.keymap.set('x', '<Leader><Space>', ':s/\\s\\+$//g<CR>', { silent = true })

return {
  indent_all = indent_all,
  delete_space = delete_space,
  delete_space_visual = delete_space_visual,
  align_code = align_code,
  align_all_buf = align_all_buf,
} 