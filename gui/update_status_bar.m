function update_status_bar(fraction)
  status_bar_length = 60;
  if i > 0
    for j = 1:status_bar_length + 2
      printf("\b")
    endfor
  endif

  printf("[")
  for j = 1:status_bar_length
    if ((j / status_bar_length) <= fraction)
      printf("=")
    else
      printf(' ')
    endif
  endfor
  printf("]")
endfunction
