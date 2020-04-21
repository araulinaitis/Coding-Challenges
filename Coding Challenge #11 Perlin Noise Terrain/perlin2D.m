function s = perlin2D (m, n)

% modified from http://www.semifluid.com/2012/12/05/2d-and-3d-perlin-noise-in-matlab/

  s = zeros([m,n]);     % Prepare output image (size: m x n)
  w = m;
  i = 0;
  while w > 3
    i = i + 1;
    d = interp2(randn([m,n]), i-1, 'spline');
    s = s + i * d(1:m, 1:n);
    w = w - ceil(w/2 - 1);
  end
  s = (s - min(min(s(:,:)))) ./ (max(max(s(:,:))) - min(min(s(:,:))));
end