" From: https://stackoverflow.com/a/28398359/1827360
function! latexencode#get_visual_selection(mode)
    " call with visualmode() as the argument
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end]     = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if a:mode ==# 'v'
        " Must trim the end before the start, the beginning will shift left.
        let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][column_start - 1:]
    elseif  a:mode ==# 'V'
        " Line mode no need to trim start or end
    elseif  a:mode == "\<c-v>"
        " Block mode, trim every line
        let new_lines = []
        let i = 0
        for line in lines
            let lines[i] = line[column_start - 1: column_end - (&selection == 'inclusive' ? 1 : 2)]
            let i = i + 1
        endfor
    else
        return ''
    endif
    return join(lines, "\n")
endfunction

function! latexencode#latextranscode(cmd) abort
  let selected_text = latexencode#get_visual_selection(visualmode())
  let command = "echo \"".selected_text->substitute('\\', '\\\\\', "g")."\" | ".a:cmd
  let encoded_text = trim(system(command))

  :execute "'<,'>s/".escape(selected_text, '\')."/".escape(encoded_text, '\')."/"
  redraw
endfunction

function! latexencode#latexencode() abort
  call latexencode#latextranscode('latexencode --quiet')
endfunction

function! latexencode#latex2text() abort
  call latexencode#latextranscode('latex2text --quiet')
endfunction
