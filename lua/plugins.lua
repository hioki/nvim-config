return {
  { "Shougo/dein.vim" },
  { "Shougo/vimproc.vim", build = "make -f make_mac.mak" },
  {
    "Shougo/deoplete.nvim",
    config = function()
      vim.g["deoplete#max_menu_width"] = 180
      vim.g.go_bin_path = os.getenv("HOME") .. "/go/bin"
    end,
  },
  {
    "Shougo/denite.nvim",
    config = function()
      vim.cmd [[
        autocmd FileType denite call s:denite_my_settings()
        function! s:denite_my_settings() abort
          call denite#custom#var('grep','command',['rg'])
          nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
          nnoremap <silent><buffer><expr> d   denite#do_map('do_action','delete')
          nnoremap <silent><buffer><expr> p   denite#do_map('do_action','preview')
          nnoremap <silent><buffer><expr> q   denite#do_map('quit')
          nnoremap <silent><buffer><expr> i   denite#do_map('open_filter_buffer')
          nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
          nnoremap <silent><buffer><expr> *   denite#do_map('toggle_select_all').'j'
        endfunction
      ]]
    end,
  },
  {
    "Shougo/unite.vim",
    config = function()
      vim.cmd [[
        autocmd FileType unite nnoremap <silent><buffer> <ESC><ESC> :q<CR>
        autocmd FileType unite inoremap <silent><buffer> <ESC><ESC> <ESC>:q<CR>
        autocmd FileType unite nnoremap <silent><buffer> <C-g> :q<CR>
        autocmd FileType unite inoremap <silent><buffer> <C-g> <ESC>:q<CR>
      ]]
    end,
  },
  {
    "Shougo/vimfiler.vim",
    dependencies = "Shougo/unite.vim",
    config = function()
      vim.cmd [[
        call vimfiler#custom#profile('default','context',{ 'safe':0,'auto_expand':1,'parent':0 })
        let g:vimfiler_as_default_explorer=1
        let g:vimfiler_tree_leaf_icon=' '
        let g:vimfiler_tree_opened_icon='▾'
        let g:vimfiler_tree_closed_icon='▸'
        let g:vimfiler_file_icon='-'
        let g:vimfiler_marked_file_icon='*'
        autocmd FileType vimfiler call s:vimfiler_my_settings()
        function! s:vimfiler_my_settings() abort
          nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('vsplit')
          nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('split')
          nnoremap <silent><buffer><expr> t vimfiler#do_action('tabopen')
          nunmap <buffer> <C-l>
        endfunction
        nnoremap <silent> fe :VimFilerBufferDir -quit<CR>
      ]]
    end,
  },
  {
    "thinca/vim-quickrun",
    config = function()
      vim.g.quickrun_config = {
        _ = { runner = "vimproc", ["runner/vimproc/updatetime"] = 60 },
        ruby = { command = "ruby", exec = { "%c %s" } },
        python = { command = "python3", exec = { "%c %s" } },
        typescript = { command = "ts-node", exec = { "%c %s" } },
        rust = { command = "cargo", exec = { "%c run --quiet %s" } },
      }
    end,
  },
  {
    "cocopon/iceberg.vim",
    config = function()
      vim.cmd [[
        au VimEnter * nested colorscheme iceberg
        au VimEnter * highlight Visual ctermbg=16
      ]]
    end,
  },
  "thinca/vim-visualstar",
  "jiangmiao/auto-pairs",
  { "tomtom/tcomment_vim", config = function() vim.g.tcomment_opleader1 = "gc" end },

  "vim-scripts/camelcasemotion",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "vim-scripts/vcscommand.vim",
  "tpope/vim-dispatch",
  "simeji/winresizer",
  "nvim-lualine/lualine.nvim",
  "sbdchd/neoformat",
  "github/copilot.vim",

  { "cespare/vim-toml",    ft = "toml" },

  {
    "powerman/vim-plugin-AnsiEsc",
    ft = "quickrun",
    dependencies = { "thinca/vim-quickrun" },
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && yarn install",
    config = function()
      vim.g.mkdp_auto_start         = 0
      vim.g.mkdp_auto_close         = 0
      vim.g.mkdp_refresh_slow       = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world  = 0
      vim.g.mkdp_open_ip            = ""
      vim.g.mkdp_browser            = ""
      vim.g.mkdp_echo_preview_url   = 0
      vim.g.mkdp_browserfunc        = ""
      vim.g.mkdp_preview_options    = {
        mkit                = {},
        katex               = {},
        uml                 = {},
        maid                = {},
        disable_sync_scroll = 0,
        sync_scroll_type    = "middle",
        hide_yaml_meta      = 1,
        sequence_diagrams   = {},
      }
      vim.g.mkdp_markdown_css       = ""
      vim.g.mkdp_highlight_css      = ""
      vim.g.mkdp_port               = ""
      vim.g.mkdp_page_title         = "「${name}」"
    end,
  },
}
