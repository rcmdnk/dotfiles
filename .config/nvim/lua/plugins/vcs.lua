return {
  -- Git
  {
    'tpope/vim-fugitive',
    cmd = {
      'Git',
      'Gwrite',
      'Gread',
      'Gdiff',
      'Gvdiff',
      'Gstatus',
      'Gcommit',
      'Gblame',
      'Gmerge',
      'Gpull',
      'Gpush',
      'Gfetch',
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