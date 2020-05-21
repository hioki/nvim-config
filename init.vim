let mapleader = ","

set mouse=a
set termguicolors
set nofoldenable
set laststatus=2
set ambiwidth=double
set autoread
set hidden
set backspace=indent,eol,start
set formatoptions=lmoq
set number
set nonumber
set showmatch
set nobackup
set nowritebackup
set noswapfile
set expandtab
set shiftwidth=2
set list
set tabstop=2
set visualbell t_vb=
set wildmode=longest:list
set listchars=tab:>.,trail:_,extends:>,precedes:<
set display=uhex
set lazyredraw
set autoindent
set smartindent
set directory-=.
set smarttab
set textwidth=0
set timeoutlen=500
set incsearch
set nowrapscan
set hlsearch
set noignorecase
set smartcase
set whichwrap=b,s,h,l,<,>,[,]
set ttimeout
set ttimeoutlen=50

if &compatible
  set nocompatible
endif

let s:dein_cache_path = expand('~/.cache/nvim/dein')
let s:dein_dir        = s:dein_cache_path . '/repos/github.com/Shougo/dein.vim'

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
  if system('uname -s') == "Darwin\n"
    call dein#load_toml('~/.config/nvim/deinlazy_Darwin.toml', {'lazy': 1})
  else
    call dein#load_toml('~/.config/nvim/deinlazy_Linux.toml', {'lazy': 1})
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

autocmd FileType gitcommit setlocal nofoldenable

"
" Key mapping: Natural movement
"
nnoremap j gj
onoremap j gj
xnoremap j gj
nnoremap k gk
onoremap k gk
xnoremap k gk

"
" Key mapping: Pane movement
"
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k

"
" Key mapping: Matchit
"
runtime macros/matchit.vim
nmap <Tab> %
vmap <Tab> %
vmap m %

"
" Key mapping: Normal Mode
"
nnoremap <silent> Q :<C-u>set paste!<CR>
nnoremap <silent> W :<C-u>set wrap!<CR>
nnoremap <silent> S :<C-u>set number!<CR>
nnoremap <silent> Y :<C-u>syntax sync fromstart<CR>
nnoremap <silent> F :<C-u>:w !pbcopy<CR><CR>
vnoremap <silent> F :<C-u>:'<,'>w !pbcopy<CR><CR>
nnoremap <silent> <C-n> :<C-u>bnext<CR>
nnoremap <silent> <C-p> :<C-u>bprevious<CR>
nnoremap <silent> <C-Up> :<C-u>cprevious<CR>
nnoremap <silent> <C-Down> :<C-u>cnext<CR>
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" Key mapping: Tag Jump
nnoremap <C-\> g<C-]>
nnoremap <C-u> <C-t>

"
" Key mapping: Visual Mode
"
vnoremap <Space> :EasyAlign *
vnoremap \ :EasyAlign *
vnoremap - :Alignta 
vnoremap <silent> <C-p> "0p<CR>
vnoremap v $h

"
" Key mapping: Insert Mode
"
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <C-o>O
inoremap <C-f> <C-o>o
inoremap <C-d> <Del>

"
" Key mapping: [SCRAMBLED]
"
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
nnoremap <silent> [SCRAMBLED]e :<C-u>NERDTree<CR>
nnoremap <silent> [SCRAMBLED]d :<C-u>VCSDiff<CR>
nnoremap <silent> [SCRAMBLED]/ :<C-u>VCSDiff<CR>
nnoremap <silent> [SCRAMBLED]D :<C-u>Gvdiff<CR>
nnoremap <silent> [SCRAMBLED]k :<C-u>Denite -start-filter=1 -buffer-name=gtags_path gtags_path<CR>
nnoremap [SCRAMBLED]r :<C-u>Denite -start-filter=1 -buffer-name=gtags_ref gtags_ref -input=
nnoremap <silent> [SCRAMBLED]b :<C-u>Denite buffer<CR>
nnoremap <silent> [SCRAMBLED]a :<C-u>A<CR>
nnoremap <silent> [SCRAMBLED]f :<C-u>Denite -start-filter=1 file/rec<CR>

nnoremap <expr> [SCRAMBLED]E ':NeoSnippetEdit '.expand(&filetype).'<CR>'
nnoremap <expr> [SCRAMBLED]S ':NeoSnippetSource ~/.vim/snippets/'.expand(&filetype).'.snip<CR>'
nnoremap <silent> [SCRAMBLED]@ :<C-u>OpenBrowser https://www.stackage.org/lts-8.24/hoogle?q=<C-r>=expand("<cword>")<CR><CR>
nnoremap [SCRAMBLED]L :<C-u>UniteWithCursorWord line<CR>
" nnoremap <silent> [SCRAMBLED]<CR> :<C-u>TREPLSendFile<CR>
nnoremap <silent> [SCRAMBLED]s :<C-u>TagbarToggle<CR>
nnoremap <silent> [SCRAMBLED]t :<C-u>Gbrowse<CR>

"
" Key mapping: [BUFFER]
"
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

"
" Key mapping: [WINDOW]
"
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

"
" Key mapping: [FILETYPE]
"
nnoremap [FILETYPE] <Nop>
xnoremap [FILETYPE] <Nop>
nmap z [FILETYPE]
xmap z [FILETYPE]
nnoremap [FILETYPE] :<C-u>set filetype=
nnoremap [FILETYPE]v :<C-u>set filetype=vim<CR>
nnoremap [FILETYPE]m :<C-u>set filetype=markdown<CR>
nnoremap [FILETYPE]d :<C-u>set filetype=diff<CR>
nnoremap [FILETYPE]r :<C-u>set filetype=ruby<CR>
nnoremap [FILETYPE]b :<C-u>set filetype=ruby.bundle<CR>
nnoremap [FILETYPE]j :<C-u>set filetype=javascript<CR>
nnoremap [FILETYPE]h :<C-u>set filetype=html<CR>
nnoremap [FILETYPE]c :<C-u>set filetype=coffee<CR>
nnoremap [FILETYPE]k :<C-u>set filetype=haskell<CR>

"
" Key mapping: [ENCODING]
"
nnoremap [ENCODING] <Nop>
xnoremap [ENCODING] <Nop>
nmap E [ENCODING]
xmap E [ENCODING]
nnoremap [ENCODING]S :<C-u>e ++enc=sjis<CR>

"
" Key mapping: [GIT]
"
nnoremap [GIT] <Nop>
xnoremap [GIT] <Nop>
nmap Z [GIT]
xmap Z [GIT]
nnoremap [GIT]Z :<C-u>x<CR>
nnoremap [GIT]W :<C-u>Gwrite<CR>
nnoremap [GIT]C :<C-u>Gcommit<CR>
nnoremap [GIT]M :<C-u>Gcommit --amend --no-edit<CR>
nnoremap [GIT]R :<C-u>Gread<CR>
nnoremap [GIT]B :<C-u>Gblame<CR>
nnoremap [GIT]D :<C-u>Gdiff<CR>
nnoremap [GIT]L :<C-u>Glog<CR>
nnoremap <silent> [GIT]S :<C-u>Dispatch hub browse<CR>
