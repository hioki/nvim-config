" autocmd VimEnter * nested :TagbarOpen

let g:neosnippet#disable_runtime_snippets = { 'go' : 1 }

set autowrite
set updatetime=500

let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <Leader>b :<C-u>DlvToggleBreakpoint<CR>
autocmd FileType go nmap <leader>B :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>D <Plug>(go-def)
autocmd FileType go nmap <Leader>e :<C-u>GoErrCheck<CR>
autocmd FileType go nmap <leader>f :<C-u>GoDeclsDir<CR>
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <leader>l <Plug>(go-alternate-edit)
autocmd FileType go nmap <leader>m <Plug>(go-doc)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>s <Plug>(go-def-stack)
autocmd FileType go nmap <leader>S <Plug>(go-def-stack-clear)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>d :<C-u>DlvDebug<CR>
