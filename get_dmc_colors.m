function dmc_colors = get_dmc_colors(raw_colors)
  % TODO
  %
  %
  %

  # -------------------- Read dmc file
  dmc_color_file = fileread('data/DMC Colors.csv');
  dmc_cell = textscan(dmc_color_file, "%s %s %n %n %n %s", 'Delimiter', ',');
  cell_fields = {"colors", "name", "r", "g", "b", "hex"};
  dmc = cell2struct(dmc_cell, cell_fields, 2);

  dmc_rgb_list = [dmc.r, dmc.g, dmc.b]';
  dmc_hsl_list = rgb2hsl([dmc.r, dmc.g, dmc.b])';
##  dmc_rgb_list(:, 1:10)
##  dmc_hsl_list(:, 1:10)
  dmc_color_codes = char(dmc.colors);
  dmc_names = char(dmc.name);

  # -------------------- Loop through
  hsl_pattern_colors = rgb2hsl(raw_colors')';

  grayscale_idx = [];

##  difference = kmeans.calculate_distance(dmc_hsl_list, hsl_pattern_colors);
  for i = 1:columns(hsl_pattern_colors)
    diff = abs(dmc_hsl_list - hsl_pattern_colors(:, i));
    if hsl_pattern_colors(2, i) < 0.1
      weights = [0; 1; 1];
      grayscale_idx = [grayscale_idx i];
    else
      weights = [3; 3; 1];
    endif
    weighted_diff = weights .* diff;
    difference(i, :) = sqrt(sum(weighted_diff.^2));
  endfor
##  diff(:, 1:10)
##  weighted_diff(:, 1:10)
  [~, idx] = min(difference');

  dmc_color_rgb = [];
  dmc_color_hsl = [];
  dmc_colors_code = char([]);
  dmc_color_names = char([]);

  for i = 1:columns(raw_colors)
    dmc_color_rgb = [dmc_color_rgb, dmc_rgb_list(:, idx(i))];
    dmc_colors_code = [dmc_colors_code; dmc_color_codes(idx(i), :)];
    dmc_color_names = [dmc_color_names; dmc_names(idx(i), :)];
  endfor

##  dmc_color.rgb = dmc_rgb_list(:, idx(i));
##  dmc_color.code = dmc_color_codes(idx(i), :);
##  dmc_color.name

##  dmc_color_rgb = hsl2rgb(dmc_color_hsl')';

  input_centroids_rgb = raw_colors
  input_centroids_hsl = rgb2hsl(raw_colors')'
  closest_dmc_color_in_hsl = dmc_hsl_list(:, idx)
  closest_dmc_color_in_hsl_converted_to_rgb = hsl2rgb(dmc_hsl_list(:, idx)')'
  grayscale_idx

  dmc_colors.rgb = dmc_color_rgb;
  dmc_colors.code = dmc_colors_code;
  dmc_colors.name = dmc_color_names;

endfunction

