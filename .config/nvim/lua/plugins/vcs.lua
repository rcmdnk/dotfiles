return {
  -- Git
  {
    'tpope/vim-fugitive',
    cmd = {
      'Git',
      'Gwrite',
      'Gread',
      'Gvdiffsplit',
    },
    keys = {
      { '<leader>gs', ':Git<CR>', desc = 'Git Status' },
      { '<leader>gd', ':Gdiffsplit<CR>', desc = 'Git Diff Split' },
      { '<leader>gb', ':Git blame<CR>', desc = 'Git Blame' },
    },
  },

  {
    'gregsexton/gitv',
    dependencies = { 'tpope/vim-fugitive' },
    cmd = 'Gitv',
  },

  -- Gist
  {
    'mattn/gist-vim',
    dependencies = { 'mattn/webapi-vim' },
    cmd = 'Gist',
    config = function()
      vim.g.gist_detect_filetype = 1
      vim.g.gist_open_browser_after_post = 1
      -- Disable default Gist command
      vim.cmd([[cnoremap <silent> Gist<CR> echo 'use Gist -P to make a public gist'<CR>]])
    end,
  },
} 
