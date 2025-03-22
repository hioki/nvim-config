set termguicolors
set number
set showmatch
set list
set autoread
set hidden
set lazyredraw
set autoindent
set smartindent
set smarttab
set incsearch
set hlsearch
set smartcase
set ttimeout
set nofoldenable
set nobackup
set nowritebackup
set noswapfile
set noexpandtab
set nowrapscan
set noignorecase
set shiftwidth=4
set tabstop=4
set laststatus=2
set textwidth=0
set timeoutlen=500
set ttimeoutlen=50
set mouse=a
set ambiwidth=double
set backspace=indent,eol,start
set formatoptions=lmoq
set visualbell t_vb=
set wildmode=longest:list
set listchars=tab:>.,trail:_,extends:>,precedes:<
set display=uhex
set directory-=.
set whichwrap=b,s,h,l,<,>,[,]

let s:dein_cache_path = expand('~/.cache/nvim/dein')
let s:dein_dir        = s:dein_cache_path . '/repos/github.com/Shougo/dein.vim'

let g:python3_host_prog = "$HOME/.anyenv/envs/pyenv/shims/python3"

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)
  call dein#load_toml('~/.config/nvim/dein.toml',     {'lazy': 0})
  call dein#load_toml('~/.config/nvim/deinlazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

nnoremap j gj
onoremap j gj
xnoremap j gj
nnoremap k gk
onoremap k gk
xnoremap k gk

nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

nnoremap <silent> Q :<C-u>set paste!<CR>
nnoremap <silent> W :<C-u>set wrap!<CR>
nnoremap <silent> S :<C-u>set number!<CR>

nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k

nnoremap <silent> <C-n> :<C-u>bnext<CR>
nnoremap <silent> <C-p> :<C-u>bprevious<CR>

vnoremap <silent> F :<C-u>:'<,'>w !pbcopy<CR><CR>
vnoremap v $h

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <C-o>O
inoremap <C-f> <C-o>o
inoremap <C-d> <Del>

runtime macros/matchit.vim
nmap <Tab> %
vmap <Tab> %
vmap m %

nnoremap [SCRAMBLED] <Nop>
xnoremap [SCRAMBLED] <Nop>
nmap g [SCRAMBLED]
vmap g [SCRAMBLED]
nnoremap [SCRAMBLED]v gv
nnoremap [SCRAMBLED]g gg
vnoremap [SCRAMBLED]g gg
nnoremap <silent> [SCRAMBLED], :<C-u>edit $HOME/.config/nvim/<CR>
nnoremap [SCRAMBLED]. :<C-u>source $HOME/.config/nvim/init.vim<CR>
nnoremap [SCRAMBLED]h ^
vnoremap [SCRAMBLED]h ^
nnoremap [SCRAMBLED]l $
vnoremap [SCRAMBLED]l $<Left>
nnoremap <silent> [SCRAMBLED]<Space> :<C-u>QuickRun<CR>
nnoremap <silent> [SCRAMBLED]j :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> [SCRAMBLED]d :<C-u>VCSDiff<CR>
nnoremap <silent> [SCRAMBLED]D :<C-u>Gvdiff<CR>
nnoremap <silent> [SCRAMBLED]b :<C-u>Git blame<CR>

nnoremap [BUFFER] <Nop>
xnoremap [BUFFER] <Nop>
nmap <CR> [BUFFER]
xmap <CR> [BUFFER]
nnoremap <silent> [BUFFER]n :<C-u>new<CR>
nnoremap <silent> [BUFFER]v :<C-u>vnew<CR>
nnoremap <silent> [BUFFER]N :<C-u>split<CR>
nnoremap <silent> [BUFFER]V :<C-u>vsplit<CR>
nnoremap <silent> [BUFFER]h :<C-u>hide<CR>
nnoremap <silent> [BUFFER]d :<C-u>bd!<CR>
nnoremap <silent> [BUFFER]q :<C-u>q!<CR>
nnoremap <silent> [BUFFER]Q :<C-u>qall!<CR>

nnoremap [WINDOW] <Nop>
xnoremap [WINDOW] <Nop>
nmap s [WINDOW]
xmap s [WINDOW]
nnoremap [WINDOW]h <C-w>h
nnoremap [WINDOW]j <C-w>j
nnoremap [WINDOW]k <C-w>k
nnoremap [WINDOW]l <C-w>l
nnoremap [WINDOW]rh <C-w>H
nnoremap [WINDOW]rj <C-w>J
nnoremap [WINDOW]rk <C-w>K
nnoremap [WINDOW]rl <C-w>L
nnoremap [WINDOW]dh <C-w>h:<C-u>bd!<CR>
nnoremap [WINDOW]dj <C-w>j:<C-u>bd!<CR>
nnoremap [WINDOW]dk <C-w>k:<C-u>bd!<CR>
nnoremap [WINDOW]dl <C-w>l:<C-u>bd!<CR>

nnoremap [FILETYPE] <Nop>
xnoremap [FILETYPE] <Nop>
nmap z [FILETYPE]
xmap z [FILETYPE]
nnoremap [FILETYPE] :<C-u>set filetype=

autocmd FileType gitcommit setlocal nofoldenable tw=0 wrap formatoptions<
autocmd FileType quickrun AnsiEsc
autocmd FileType qf nnoremap <CR> <C-w><CR><C-w>T

lua << END
require('lualine').setup()
END
