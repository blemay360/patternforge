classdef kmeans
  properties
    distance;
    k;
    data;
    centroids;
    prev;
    orig;
    error;
    max_loops = 100000;
    idx;
    converged = false;
    loops = 0;
    reinits = 1;
    error_list = [];
  endproperties

  methods
    function km = kmeans(pic, k)
      km.data = kmeans.flatten(pic);
      km.k = k;
      km = km.init_centroids();
      km.distance = zeros(k, length(km.data(1, :)));
      while km.converged == false
        % ---------- Calculate distances
        km.distance = kmeans.calculate_distance(km.data, km.centroids);
        % ---------- Sort points
        [km.error, km.idx] = kmeans.sort_points(km.distance);
        % ---------- Recalculate centroids
        for i = 1:columns(km.centroids)
          cluster = km.data(:, km.idx == i);
          if !isempty(cluster)
            km.centroids(:, i) = mean(cluster, 2);
          endif
        endfor
        % ---------- Check if centroids have converged
        if all(all(abs(km.centroids - km.prev) < 0.1))
          if any(any(abs(km.centroids - km.orig) < 0.1))
            km = km.init_centroids();
            km.reinits += 1;
          else
            km.converged = true;
            km.distance = kmeans.calculate_distance(km.data, km.centroids);
            [km.error, km.idx] = kmeans.sort_points(km.distance);
            km.error = sum(km.error);
            km.idx = kmeans.unflatten(km.idx, pic);
          endif
        endif

        % ---------- Chicken way out
        if km.loops > km.max_loops
          break
        endif
        if km.reinits > km.max_loops
          break
        endif

        % ---------- Update variables for next loop
        km.prev = km.centroids;
        km.loops += 1;
        km.error_list = [km.error_list, sum(km.error)];
      endwhile
    endfunction

    function self = init_centroids(self)
      % Initializes centroid using kmeans++
      % Needs data to be a list of all data points and k to be number of desired clusters
      % Populates self.centroids with centroids and makes 2 copies called prev and orig

      % Initialize empty centroid array
      self.centroids = [];
      % Pick a random data point
      random_index = randi(size(self.data)(2));
      % Make the first centroid the random data point
      self.centroids = self.data(:, random_index);

      % Loop k - 1 times to pick the rest of the centroids
      for i = 2:self.k
        % Calculate the distance from each data point to each centroid
        distance = kmeans.calculate_distance(self.data, self.centroids);
        % Make an array of distances from each data point to the closet centroid
        % This array is proportional probability of chosing that data point as the next centroid
        % The closer a data point is to an existing centroid, the less likely it should be to be picked as the next centroid
        weights = min(distance) .^ 2;
        % Make sure all probabilites sum to 1 to compare with rand
        weights = weights / sum(weights);
        % Find the last value of the cumulative sum of the weights array that is less than a random number from 0-1
        % This is the index of the next centroid
        ind = find(rand > [0, cumsum(weights)], 1, 'last');
        % Make the new centroid the randomly chosen index
        self.centroids = [self.centroids, self.data(:, ind)];
      endfor
      % Make copies of the centroids
      self.prev = self.centroids;
      self.orig = self.centroids;
    endfunction

  endmethods

  % -------------------- STATIC METHODS

  methods (Static = true)

    function data = unflatten(idx, pic)
      data = zeros(size(pic)(1:2));
      for y = 1:size(pic)(1)
        for x = 1:size(pic)(2)
          data(y, x) = idx(:, (y - 1) * size(pic)(1) + x);
        endfor
      endfor
    endfunction

    function pixel_colors = flatten(pic)
      num_pixels = size(pic)(1) * size(pic)(2);
      pixel_colors =  zeros(3, num_pixels);
      for y = 1:size(pic)(1)
        for x = 1:size(pic)(2)
          pixel_colors(:, (y - 1) * size(pic)(1) + x) = pic(y, x, :);
        endfor
      endfor
    endfunction

    function [error, idx] = sort_points(distance)
      [error, idx] = min(distance);
    endfunction

    function distance = calculate_distance(data, centroid)
      for i = 1:columns(centroid)
        diff = abs(data - centroid(:, i));
        distance(i, :) = sqrt(sum(diff.^2));
      endfor
    endfunction

  endmethods

endclassdef
