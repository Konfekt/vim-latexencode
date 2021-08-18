if &compatible || exists('g:loaded_latexencode')
    finish
endif

if !executable('latexencode')
  finish
endif

if !exists('g:latexencode_punctuation_marks')
  let g:latexencode_punctuation_marks = '?!;:'
endif

command! -range LatexEncode call latexencode#latexencode(<line1>, <line2>)
command! -range Latex2Text  call latexencode#latex2text(<line1>, <line2>)

let g:loaded_latexencode = 1
