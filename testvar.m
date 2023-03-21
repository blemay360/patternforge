##colors = ones(3, 10);
##colors(:, 1:3) = 1 * ones(3);
##colors(:, 4:6) = 2 * ones(3);
##colors(:, 7:9) = 3 * ones(3);
##colors(:, 10) = 6 * ones(3, 1)

clear all; close all;
for i = 1:10
  pattern_maker
  close all;
  km.reinits
  plot(km.error_list)
endfor
