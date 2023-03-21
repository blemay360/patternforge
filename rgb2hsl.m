function hsl = rgb2hsl(rgb)
  [M, Midx] = max(rgb, [], 2);
  [m, midx] = min(rgb, [], 2);
  C = M - m;

  H_prime = zeros(size(M));

  for i = 1:rows(rgb)
    if C(i) == 0
      H_prime(i) = 0;
    elseif Midx == 1
      H_prime(i) = mod((rgb(i, 2) - rgb(i, 3)) / C(i), 6);
    elseif Midx == 2
      H_prime(i) = (rgb(i, 3) - rgb(i, 1)) / C(i) + 2;
    elseif Midx == 3
      H_prime(i) = (rgb(i, 1) - rgb(i, 2)) / C(i) + 4;
    endif
  endfor
  H = 60 * H_prime;
  L = 0.5 * (M + m);

  S = zeros(size(M));

  for i = 1:rows(rgb)
    if L(i) == 0
      S(i) = 0;
    elseif L(i) == 1
      S(i) = 0;
    else
      S(i) = C(i) / (1 - abs(2 * L(i) - 1));
    endif
  endfor

  hsl =[H S L];
endfunction
