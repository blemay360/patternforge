function rgb = hsl2rgb(hsl)
  H =  hsl(:, 1);
  S =  hsl(:, 2);
  L =  hsl(:, 3);

  C = (1 - abs(2 .* L - 1)) .* S;
  H_prime = H / 60;
  X = C .* (1 - abs(mod(H_prime, 2) - 1));

  rgb = zeros(size(hsl));

  for i = 1:rows(hsl)
    if H_prime(i) < 1
      rgb(i, :) = [C(i), X(i), 0];
    elseif H_prime(i) < 2
      rgb(i, :) = [X(i), C(i), 0];
    elseif H_prime(i) < 3
      rgb(i, :) = [0, C(i), X(i)];
    elseif H_prime(i) < 4
      rgb(i, :) = [0, X(i), C(i)];
    elseif H_prime(i) < 5
      rgb(i, :) = [X(i), 0, C(i)];
    elseif H_prime(i) < 6
      rgb(i, :) = [C(i), 0, X(i)];
    endif
  endfor

  m = L - 0.5 .* C;

  rgb = rgb + m;

  rgb = rgb * 255;

endfunction
