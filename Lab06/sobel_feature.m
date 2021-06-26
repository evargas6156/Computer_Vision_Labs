function [magnitude, orientation] = sobel_feature(img)

% horizontal edge
Hy = [1, 2, 1; 0, 0, 0; -1, -2, -1];

% vertical edge
Hx = [1, 0, -1; 2, 0, -2; 1, 0, -1];

%% Sobel filtering
xEdge = imfilter(img, Hx);
yEdge = imfilter(img, Hy);


%% compute gradient magnitude and orientation
magnitude = sqrt(xEdge.^2 + yEdge.^2);
orientation = atan2(yEdge, xEdge);

end