"
" Autocmds
"
autocmd BufRead,BufNewFile *.crs set filetype=rust.cargoscript
autocmd BufRead,BufNewFile *.snip set filetype=neosnippet
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.uml set filetype=plantuml
autocmd BufRead,BufNewFile *.mustache set filetype=html
autocmd BufRead,BufNewFile *.cf.yaml set filetype=cloudformation.yaml
autocmd BufRead,BufNewFile *.cf.json set filetype=cloudformation.json
autocmd BufRead,BufNewFile *.tera set ft=jinja
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
autocmd FileType quickrun AnsiEsc
autocmd FileType qf nnoremap <CR> <C-w><CR><C-w>T
