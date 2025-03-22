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

require("lazy").setup("plugins")

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
