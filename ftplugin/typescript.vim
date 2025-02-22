let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'
let g:deoplete#complete_method = 'omnifunc'

nnoremap gi :<C-u>TsuImport<CR>
