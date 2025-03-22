-- Basic options
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.list = true
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.lazyredraw = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ttimeout = true
vim.opt.foldenable = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.expandtab = false
vim.opt.wrapscan = false
vim.opt.ignorecase = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.laststatus = 2
vim.opt.textwidth = 0
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 50
vim.opt.mouse = "a"
vim.opt.ambiwidth = "double"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.formatoptions = "lmoq"
vim.opt.visualbell = true
vim.cmd([[set t_vb=]])
vim.opt.wildmode = { "longest", "list" }
vim.opt.listchars = { tab = ">.", trail = "_", extends = ">", precedes = "<" }
vim.opt.display = "uhex"
vim.opt.directory:remove(".")
vim.opt.whichwrap:append("b,s,h,l,<,>,[,]")

-- Python provider
vim.g.python3_host_prog = os.getenv("HOME") .. "/.anyenv/envs/pyenv/shims/python3"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
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
      call vimfiler#custom#profile('default','context',{
            \ 'safe'       : 0,
            \ 'auto_expand': 1,
            \ 'parent'     : 0
            \ })
    ]]

      vim.g.vimfiler_as_default_explorer = true
      vim.g.vimfiler_tree_leaf_icon      = " "
      vim.g.vimfiler_tree_opened_icon    = "▾"
      vim.g.vimfiler_tree_closed_icon    = "▸"
      vim.g.vimfiler_file_icon           = "-"
      vim.g.vimfiler_marked_file_icon    = "*"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "vimfiler",
        callback = function()
          local opts = { noremap = true, silent = true, buffer = true }
          vim.keymap.set("n", "s", "<Cmd>lua vimfiler#do_switch_action('vsplit')<CR>", opts)
          vim.keymap.set("n", "v", "<Cmd>lua vimfiler#do_switch_action('split')<CR>", opts)
          vim.keymap.set("n", "t", "<Cmd>lua vimfiler#do_action('tabopen')<CR>", opts)
          vim.keymap.del("n", "<C-l>", { buffer = true })
        end,
      })

      vim.keymap.set("n", "fe", ":VimFilerBufferDir -quit<CR>", { noremap = true, silent = true })
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
})

-- Key mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move by display lines
for _, mode in ipairs({ "n", "o", "x" }) do
  map(mode, "j", "gj", opts)
  map(mode, "k", "gk", opts)
end

map("n", "<ESC><ESC>", ":nohlsearch<CR>", opts)
map("n", "Q", ":set paste!<CR>", opts)
map("n", "W", ":set wrap!<CR>", opts)
map("n", "S", ":set number!<CR>", opts)
map("n", "z", ":set filetype=", opts)

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)

-- Buffer navigation
map("n", "<C-n>", ":bnext<CR>", opts)
map("n", "<C-p>", ":bprevious<CR>", opts)

-- Clipboard yank in visual
map("v", "F", ":'<,'>w !pbcopy<CR><CR>", opts)
map("v", "v", "$h", opts)

-- Insert mode cursor movement
map("i", "<C-a>", "<Home>", opts)
map("i", "<C-e>", "<End>", opts)
map("i", "<C-b>", "<C-o>O", opts)
map("i", "<C-f>", "<C-o>o", opts)
map("i", "<C-d>", "<Del>", opts)

-- Load matchit
vim.cmd("runtime macros/matchit.vim")
map("n", "<Tab>", "%", opts)
map("v", "<Tab>", "%", opts)
map("v", "m", "%", opts)

-- Edit configuration files
map("n", "g,", ":<C-u>edit $HOME/.config/nvim/<CR>", opts)

-- Reload configuration
map("n", "g.", ":<C-u>source $HOME/.config/nvim/init.lua<CR>", opts)

-- Move to the beginning/end of the line
map("n", "gh", "^", opts)
map("v", "gh", "^", opts)
map("n", "gl", "$", opts)
map("v", "gl", "$<Left>", opts)

-- QuickRun
map("n", "g<Space>", ":<C-u>QuickRun<CR>", opts)

-- Vimfiler
map("n", "gj", ":<C-u>VimFilerBufferDir -quit<CR>", opts)

-- Git commands
map("n", "gd", ":<C-u>VCSDiff<CR>", opts)
map("n", "gD", ":<C-u>Gvdiff<CR>", opts)
map("n", "gb", ":<C-u>Git blame<CR>", opts)

-- New buffer
map("n", "<CR>n", ":new<CR>", opts)
map("n", "<CR>v", ":vnew<CR>", opts)

-- Split buffer
map("n", "<CR>N", ":split<CR>", opts)
map("n", "<CR>V", ":vsplit<CR>", opts)

-- Close buffer
map("n", "<CR>h", ":hide<CR>", opts)
map("n", "<CR>d", ":bd!<CR>", opts)
map("n", "<CR>q", ":q!<CR>", opts)
map("n", "<CR>Q", ":qall!<CR>", opts)

-- Move between windows
map("n", "sh", "<C-w>h", opts)
map("n", "sj", "<C-w>j", opts)
map("n", "sk", "<C-w>k", opts)
map("n", "sl", "<C-w>l", opts)

-- Swap windows
map("n", "srh", "<C-w>H", opts)
map("n", "srj", "<C-w>J", opts)
map("n", "srk", "<C-w>K", opts)
map("n", "srl", "<C-w>L", opts)

-- Move between windows and close
map("n", "sdh", "<C-w>h:bd!<CR>", opts)
map("n", "sdj", "<C-w>j:bd!<CR>", opts)
map("n", "sdk", "<C-w>k:bd!<CR>", opts)
map("n", "sdl", "<C-w>l:bd!<CR>", opts)

-- FileType autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.foldenable = false; vim.opt_local.tw = 0; vim.opt_local.wrap = true; vim.opt_local.formatoptions = ""
  end,
})
vim.api.nvim_create_autocmd("FileType", { pattern = "quickrun", command = "AnsiEsc" })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function() vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<C-w><CR><C-w>T", opts) end,
})

-- Lualine setup
require("lualine").setup()
