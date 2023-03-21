% -------------------- Set variables
filename = "Beaker.jpg";
##filename = "gitlab.png";
k = 8;
scale = 0.05;
max_loops = 1000;
attempts = 8;
make_figures = true;
aida_count = 16;

% -------------------- Load image
original = imread(filename);
pkg load image
downsampled = imresize(original, scale);
pic = downsampled;

in_size = size(downsampled)(1:2) / aida_count;

# -------------------- Add colors to definitely use
added_colors = [87, 115, 2; 97, 84, 78]';

close all

# -------------------- Get DMC RGB comparison
DMC_color_file = csvread('DMC Colors.csv');
##DMC_RGB_colors = textscan(text_file, "%s %[A-Za-z ] %n %n %n %s");
##DMC_colors = DMC_RGB_colors(:, 1)
