function redraw_image(original_image, colors, idx, dmc_colors)
  # Takes:
  # - an array of colors to use in drawing the image
  # - a matrix the same shape as the image, identifying the color index for each pixel
  # -

  sort_display_colors = false

  % -------------------- Show input image
  figure(1)
  subplot(151)
  imshow(original_image);
  title("Original")

  if !isempty(colors)
    % -------------------- Sort input colors
    [~, color_sort_idx] = sort(sum(colors), 'descend');
    sorted_colors = colors(:, color_sort_idx);


    % -------------------- Show colors of centroids
    subplot(152)
    if sort_display_colors
      reduced_colors = sorted_colors;
    else
      reduced_colors = colors;
    endif
    imshow(reshape(reduced_colors', size(colors)(2), 1, 3) / 255)
    title("Reduced Color Palette")


    % -------------------- Redraw image with centroid colors
    subplot(153)
    redrawn_image = original_image;
    for y = 1:size(redrawn_image)(1)
      for x = 1:size(redrawn_image)(2)
        redrawn_image(y, x, :) = colors(:, idx(y, x))';
      endfor
    endfor
    imshow(redrawn_image)
    title("Reduced Color Image")
  endif

  if !isempty(dmc_colors)
    % -------------------- Sort DMC colors
    sorted_dmc_colors = dmc_colors(:, color_sort_idx);

    % -------------------- Show approximate DMC colors
    subplot(154)
    if sort_display_colors
      dmc_display_colors = sorted_dmc_colors;
    else
      dmc_display_colors = dmc_colors;
    endif
    imshow(reshape(dmc_display_colors', size(sorted_dmc_colors)(2), 1, 3) / 255)
    title("DMC Color Palette")


    % -------------------- Redraw image with DMC colors
    subplot(155)
    redrawn_image = original_image;
    for y = 1:size(redrawn_image)(1)
      for x = 1:size(redrawn_image)(2)
        redrawn_image(y, x, :) = dmc_colors(:, idx(y, x))';
      endfor
    endfor
    imshow(redrawn_image)
    title("DMC Color Image")
  endif
  drawnow;
endfunction
