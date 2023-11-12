" https://devhints.io/vimscript
" https://stackoverflow.com/questions/56052213/testing-vim-scripts
function cs#one() abort
  let mode = mode()
  echo mode
  call assert_true('')
endfunction

call cs#one()


function cs#assert_example() abort
  if(assert_true(True)) | throw v:errors[-1] | endif
endfunction
