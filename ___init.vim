"
" Autocmds
"
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.uml set filetype=plantuml
autocmd BufRead,BufNewFile *.tera set ft=jinja
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.json setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.sh setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.bash setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType quickrun AnsiEsc
autocmd FileType qf nnoremap <CR> <C-w><CR><C-w>T
