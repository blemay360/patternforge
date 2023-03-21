% -------------------- Set variables
filename = "Beaker.jpg";
##filename = "gitlab.png";
k = 8; %8
scale = 0.05; %0.05
attempts = 1;
make_figures = true;
aida_count = 16;

% -------------------- Load image
original = imread(filename);
pkg load image
downsampled = imresize(original, scale);
pic = downsampled;

in_size = size(downsampled)(1:2) / aida_count;

# -------------------- DISPLAY ORIGINAL IMAGE
redraw_image(pic, [], [], [])

# -------------------- SET VARIABLES BEFORE STARTING LOOP
lowest_error = inf;
attempts = attempts - 1;

for i = 0:attempts
##  update_status_bar(i / attempts)
  tic;
  km = kmeans(pic, k);
  toc


% Update best result
  if km.error < lowest_error
    best_centroid = km.centroids;
    best_idx = km.idx;
    lowest_error = km.error;
    %Plot best result so far
    if make_figures
      redraw_image(pic, best_centroid, best_idx, [])
      drawnow;
    endif
  endif
endfor

# -------------------- CLEAN UP
printf("\n")
if lowest_error == inf
  printf("No attempts converged, increase maximum loops or attempts\n")
else
  DMC_colors = get_dmc_colors(best_centroid);
  redraw_image(pic, best_centroid, best_idx, DMC_colors.rgb);
  drawnow;
endif
