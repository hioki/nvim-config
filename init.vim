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

" Haskell tags
set tags=tags;/,codex.tags;/
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

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
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

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
nnoremap <silent> F :<C-u>NERDTree<CR>
nnoremap <silent> <C-n> :<C-u>bnext<CR>
nnoremap <silent> <C-p> :<C-u>bprevious<CR>
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-\> g<C-]>
nnoremap <C-u> <C-t>

nnoremap <C-g> :<C-u>GtagsCursor<CR>

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
nnoremap <silent> [SCRAMBLED]k :<C-u>DeniteProjectDir file/rec<CR>
nnoremap <silent> [SCRAMBLED]b :<C-u>Denite buffer<CR>
nnoremap <silent> [SCRAMBLED]u :<C-u>DeniteCursorWord -buffer-name=gtags_def gtags_def<CR>

" nnoremap <expr> [SCRAMBLED]E ':NeoSnippetEdit '.expand(&filetype).'<CR>'
" nnoremap <expr> [SCRAMBLED]S ':NeoSnippetSource ~/.vim/snippets/'.expand(&filetype).'.snip<CR>'
nnoremap <silent> [SCRAMBLED]@ :<C-u>OpenBrowser https://www.stackage.org/lts-8.24/hoogle?q=<C-r>=expand("<cword>")<CR><CR>
nnoremap [SCRAMBLED]L :<C-u>UniteWithCursorWord line<CR>
nnoremap <silent> [SCRAMBLED]<CR> :<C-u>TREPLSendFile<CR>
nnoremap <silent> [SCRAMBLED]t :<C-u>TagbarToggle<CR>

" nnoremap <silent> [SCRAMBLED]<CR> :<C-u>RufoOn<CR>
" nnoremap <silent> [SCRAMBLED]+ :<C-u>RufoOff<CR>

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
" Key mapping: [GIT]
"
nnoremap [GIT] <Nop>
xnoremap [GIT] <Nop>
nmap Z [GIT]
xmap Z [GIT]
" デフォルトの ZZ と同じ挙動
nnoremap [GIT]Z :<C-u>x<CR>
nnoremap [GIT]W :<C-u>Gwrite<CR>
nnoremap [GIT]C :<C-u>Gcommit<CR>
nnoremap [GIT]M :<C-u>Gcommit --amend --no-edit<CR>
nnoremap [GIT]R :<C-u>Gread<CR>
nnoremap [GIT]B :<C-u>Gblame<CR>
nnoremap [GIT]D :<C-u>Gdiff<CR>
nnoremap [GIT]L :<C-u>Glog<CR>
nnoremap <silent> [GIT]S :<C-u>Dispatch hub browse<CR>

"
" Autocmds
"
autocmd MyAutoCmd BufRead,BufNewFile *.snip  set filetype=snippet
autocmd MyAutoCmd BufRead,BufNewFile *.md  set filetype=markdown
autocmd MyAutoCmd BufRead,BufNewFile *.uml  set filetype=plantuml
autocmd MyAutoCmd BufRead,BufNewFile *.mustache  set filetype=html
autocmd MyAutoCmd TermOpen * setlocal norelativenumber
autocmd MyAutoCmd TermOpen * setlocal nonumber
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType quickrun AnsiEsc

"
" Matchit
"
runtime macros/matchit.vim

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

autocmd FileType gitcommit setlocal nofoldenable

"
" Vue.js
"
autocmd FileType vue syntax sync fromstart

"
" QuickRun
"
let g:quickrun_config = {
  \ "_" : {
  \   "runner" : "vimproc",
  \   "runner/vimproc/updatetime" : 60
  \ },
  \ "haskell" : {
  \   "exec" : "stack runghc %s"
  \ },
  \ "markdown" : {
  \   "outputter" : "null",
  \   "command" : "open",
  \   "cmdopt" : "-a",
  \   "args" : "Marked",
  \   "exec" : "%c %o %a %s",
  \ },
  \ "rst" : {
  \   "outputter" : "null",
  \   "command" : "open",
  \   "cmdopt" : "-a",
  \   "args" : "Marked",
  \   "exec" : "%c %o %a %s",
  \ },
  \ 'ruby': {
  \   'command': 'ruby',
  \   'exec': '%c %s'
  \ },
  \ 'ruby.bundle': {
  \   'command': 'ruby',
  \   'exec': 'bundle exec %c %s'
  \ },
  \ 'rspec/normal': {
  \   'type': 'rspec/normal',
  \   'command': 'rspec',
  \   'exec': '%c %s'
  \ },
  \ 'rspec/bundle': {
  \   'type': 'rspec/bundle',
  \   'command': 'rspec',
  \   'exec': 'bundle exec %c %s'
  \ },
  \ 'python': {
  \   'command': 'python3',
  \   'exec': ['%c %s']
  \ },
  \ 'swift': {
  \   'command': 'swift',
  \   'exec': ['%c %s']
  \ },
  \ 'jsx': {
  \   'command': './node_modules/.bin/babel',
  \   'outputter': 'buffer:filetype=javascript',
  \   'exec': ['%c %s']
  \ },
  \ 'dhall': {
  \   'outputter': 'buffer:filetype=json',
  \   'command': 'dhall-to-json',
  \   'exec': ['%c --explain --pretty --omitNull <%s']
  \ },
  \ 'typescript': {
  \   'command': 'ts-node',
  \   'exec': ['%c %s']
  \ },
  \ 'coffee': {
  \   'command': 'coffee',
  \   'outputter': 'buffer:filetype=javascript',
  \   'exec': ['%c -cbp %s']
  \ }}

function! RSpecQuickrun()
  let b:quickrun_config = {'type' : 'rspec/bundle'}
endfunction
autocmd MyAutoCmd BufReadPost *_spec.rb call RSpecQuickrun()

"
" VimFiler
"
call vimfiler#custom#profile('default', 'context', {
      \ 'safe' : 0,
      \ 'auto_expand' : 1,
      \ 'parent' : 0,
      \ })

"default explore -> vimfiler
let g:vimfiler_as_default_explorer = 1

"buffer directory
nnoremap <silent> fe :<C-u>VimFilerBufferDir -quit<CR>

"key mapping
autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
  nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('vsplit')
  nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('split')
  nnoremap <silent><buffer><expr> t vimfiler#do_action('tabopen')
  nunmap <buffer> <C-l>
endfunction

" Textmate icons
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

"
" iceberg
"
au MyAutoCmd VimEnter * nested colorscheme iceberg
au MyAutoCmd VimEnter * highlight Visual ctermbg=16


"
" tomtom/tcomment_vim
"
let g:tcomment_opleader1 = 'gc'

"
" Shougo/unite.vim
"
autocmd MyAutoCmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd MyAutoCmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
autocmd MyAutoCmd FileType unite nnoremap <silent> <buffer> <C-g> :q<CR>
autocmd MyAutoCmd FileType unite inoremap <silent> <buffer> <C-g> <ESC>:q<CR>

"
" Shougo/denite.nvim
"
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec', 'command', ['rg', '--files'])
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#var('grep', 'command', ['rg'])

"
" deoplete
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_menu_width = 180

let g:go_bin_path = $HOME."/go/bin"
