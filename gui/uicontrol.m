close all
clear h

graphics_toolkit qt

##dark_mode = [0.15 0.15 0.15];
background = 0.85 * ones(1, 3);

##h.ax = axes ("position", [0.05 0.42 0.5 0.5]);
##h.fcn = @(x) polyval([-0.1 0.5 3 0], x);

##h.fig = redraw_image(pic, [], [], []);

original = imresize(pic, 4);

buffer = 20;
color_bar_height = size(original)(2) / 6;
controls_height = size(original)(2);

total_width = size(original)(1) * 3 + buffer * 5;
total_height = size(original)(2) + color_bar_height + controls_height + buffer * 4;

[10 10 total_width total_height]
fig = figure(847, "position", [10 80 total_height total_height]);

image_y_pos = (total_height - size(original)(2) - buffer) / total_height;
image_width = size(original)(1) / total_width
image_height = size(original)(2) / total_height


orig_pos = [buffer / total_width, image_y_pos, image_width, image_height];
reduc_pos = [2 * buffer / total_width + image_width, image_y_pos, image_width, image_height];
dmc_pos = [3 * buffer / total_width + 2 * image_width, image_y_pos, image_width, image_height];

##h.orig = axes('ycolor', 'none', 'xcolor', 'none','position', orig_pos);
h.orig = imshow(original);
set(h.orig, 'position', orig_pos)

h.reduc = axes('ycolor', 'none', 'xcolor', 'none', 'position', reduc_pos);
imshow(original)

h.dmc = axes('ycolor', 'none', 'xcolor', 'none', 'color', background, 'position', dmc_pos);
imshow(original)

h.dmc_colors = axes('ycolor', 'none', 'xcolor', 'none',...
                    'position', [3 * buffer / total_width + 2 * image_width, image_y_pos - (buffer + color_bar_height) / total_height, image_width, color_bar_height / total_height]);
imshow(reshape(sorted_colors', 1, size(colors)(2), 3) / 255)

##set (gcf, "color", get(0, "defaultuicontrolbackgroundcolor"))
set (gcf, "color", background)
guidata (gcf, h)
