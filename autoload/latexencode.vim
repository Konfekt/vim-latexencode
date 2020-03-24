function! latexencode#latexencode(start, end) abort
  normal! m`
  " join all lines
  exe a:start . ',' . a:end . 'join'

  " put one sentence onto one line
  let gdefault = &gdefault
  set gdefault&

  let subst =
      \ '\C\v(%(%([^[:digit:]IVX]|[\])''"])[.]|[' . g:latexencode_punctuation_marks . '])[[:space:]\])''"])' 
      \ . '/'
      \ .'\1\r'
  exe 'silent keeppatterns ' . "'[,']" . 'substitute/' . subst . '/geI'

  " convert unicode symbols to LaTeX commands
  exe "'[,']" . '!latexencode --quiet'

  " replace \\ensuremath{...} by $...$
  exe 'silent keeppatterns ' . "'[,']" . 'substitute/\v\\ensuremath[{]([^}]+)[}]/$\1$/geI'
  " replace $...$ $...$ by $... ...$
  exe 'silent keeppatterns ' . "'[,']" . 'substitute/\v\$\s+\$/ /geI'

  let &gdefault = gdefault
  normal! g``
endfunction!
