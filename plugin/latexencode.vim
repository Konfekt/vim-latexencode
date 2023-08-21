if &compatible || exists('g:loaded_latexencode')
    finish
endif

if !executable('latexencode')
  finish
endif

command! -range LatexEncode call latexencode#latexencode()
command! -range Latex2Text  call latexencode#latex2text()

let g:loaded_latexencode = 1
