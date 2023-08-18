function! latexencode#latexencode(start, end) abort
  normal! m`
  " convert unicode symbols to LaTeX commands
  keepjumps exe a:start . ',' . a:end . '!latexencode --quiet'
  normal! g``
endfunction

function! latexencode#latex2text(start, end) abort
  normal! m`
  " convert unicode symbols to LaTeX commands
  keepjumps exe a:start . ',' . a:end . '!latex2text --quiet'
  normal! g``
endfunction
