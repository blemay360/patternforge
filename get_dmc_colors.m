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
  dmc_color_codes = char(dmc.colors);
  dmc_names = char(dmc.name);

  # -------------------- Loop through
  hsl_pattern_colors = rgb2hsl(raw_colors')';

  difference = kmeans.calculate_distance(dmc_hsl_list, hsl_pattern_colors);
  size(difference);
  [error, idx] = min(difference');

  dmc_color_rgb = [];
  dmc_color_hsl = [];
  dmc_colors_code = char([]);
  dmc_color_names = char([]);

  for i = 1:columns(raw_colors)
    dmc_color_hsl = [dmc_color_hsl, dmc_hsl_list(:, idx(i))];
    dmc_colors_code = [dmc_colors_code; dmc_color_codes(idx(i), :)];
    dmc_color_names = [dmc_color_names; dmc_names(idx(i), :)];
  endfor

##  dmc_color.rgb = dmc_rgb_list(:, idx(i));
##  dmc_color.code = dmc_color_codes(idx(i), :);
##  dmc_color.name

  dmc_color_rgb = hsl2rgb(dmc_color_hsl')';

  dmc_colors.rgb = dmc_color_rgb;
  dmc_colors.code = dmc_colors_code;
  dmc_colors.name = dmc_color_names;

endfunction

