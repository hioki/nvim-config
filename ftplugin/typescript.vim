let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'
let g:deoplete#complete_method = 'omnifunc'
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

nnoremap gi :<C-u>TsuImport<CR>
