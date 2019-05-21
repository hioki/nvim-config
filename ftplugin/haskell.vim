let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1

nnoremap <expr> [SCRAMBLED]<CR> ':Dash '.expand("<cword>").'<CR>'

nnoremap [TAG] <Nop>
xnoremap [TAG] <Nop>
nmap ] [TAG]
xmap ] [TAG]
nnoremap [TAG]] :<C-u>TagbarToggle<CR>
nnoremap [TAG]a :ta<SPACE>
nnoremap [TAG]s :ts<SPACE>

" ----- neovimhaskell/haskell-vim -----
let g:haskell_indent_if = 2
let g:haskell_indent_case = 2
let g:haskell_indent_let = 0
let g:haskell_indent_where = 6
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 2
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2

" ----- hindent -----
let g:hindent_on_save = 0

function! HaskellFormat(which) abort
  if a:which ==# 'hindent' || a:which ==# 'both'
    :Hindent
  endif
  if a:which ==# 'stylish' || a:which ==# 'both'
    silent! exe 'undojoin'
    silent! exe 'keepjumps %!stylish-haskell'
  endif
endfunction

nnoremap <leader>hi :Hindent<CR>
" Just stylish-haskell
nnoremap <leader>hs :call HaskellFormat('stylish')<CR>
" First hindent, then stylish-haskell
nnoremap <silent> <leader>f mz:call HaskellFormat('both')<CR>`z:w<CR>

" ----- w0rp/ale -----

let g:ale_linters.haskell = ['stack-ghc-mod', 'hlint']

" ----- parsonsmatt/intero-neovim -----

" Prefer starting Intero manually (faster startup times)
let g:intero_start_immediately = 0

" Use ALE (works even when not using Intero)
let g:intero_use_neomake = 0

let g:intero_type_on_hover = 0

" Intero Mappings
nnoremap <silent> <Leader>o :InteroOpen<CR>
nnoremap <silent> <Leader>k :InteroKill<CR>
nnoremap <silent> <Leader>r :InteroReload<CR>
nnoremap <silent> <Leader>lm :InteroLoadCurrentModule<CR>
nnoremap <silent> <Leader>lf :InteroLoadCurrentFile<CR>
map <silent> <Leader>t <Plug>InteroGenericType
vmap <Leader>t <Plug>InteroGenericType
nnoremap <silent> <Leader>T :InteroTypeInsert<CR>
nnoremap <silent> <Leader>d :InteroGoToDef<CR>
nnoremap <silent> <Leader>n :InteroUses<CR>

" ----- Haskell tags -----
" NOTE: mz で z にマークして最後に `z でマークした地点に戻っている。
"       これをしないと実行した後次の行の先頭になってしまう。
nnoremap <silent> [SCRAMBLED]t mz:!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>`z

set csprg=hscope
set csto=1

nnoremap <silent> <C-d> :cs find c <C-R>=expand("<cword>")<CR><CR>

" Automatically make cscope connections
function! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /*.hs call LoadHscope()
