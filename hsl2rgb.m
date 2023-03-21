function rgb = hsl2rgb(hsl)
  H =  hsl(:, 1);
  S =  hsl(:, 2);
  L =  hsl(:, 3);

  C = (1 - abs(2 .* L - 1)) .* S;
  H_prime = H / 60;
  X = C .* (1 - abs(mod(H_prime, 2) - 1));

  rgb = zeros(size(hsl))

  for i = 1:rows(hsl)
    if H_prime(i) < 1
      rgb(i, :) = [C, X, 0];
    elseif H_prime(i) < 2
      rgb(i, :) = [X, C, 0];
    elseif H_prime(i) < 3
      rgb(i, :) = [0, C, X];
    elseif H_prime(i) < 4
      rgb(i, :) = [0, X, C];
    elseif H_prime(i) < 5
      rgb(i, :) = [X, 0, C];
    elseif H_prime(i) < 6
      rgb(i, :) = [C, 0, X];
    endif
  endfor

  m = L - 0.5 .* C;

  rgb = rgb + m;

endfunction
