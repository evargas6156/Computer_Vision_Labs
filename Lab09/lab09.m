
run('vlfeat-0.9.21/toolbox/vl_setup');

img1 = im2single(imread('prtn13.jpg'));
img2 = im2single(imread('prtn12.jpg'));

%% SIFT feature extraction

%change them both to grey scale
I1 = rgb2gray(img1);
I2 = rgb2gray(img2);

%perform sift extraction
[f1, d1] = vl_sift(I1);
[f2, d2] = vl_sift(I2);

%convert to double
d1 = double(d1);
d2 = double(d2);

%plot features
%plot_sift(img1, f1, d1);
%plot_sift(img2, f2, d2);

%% feature matching

%call function to match features
[matches, scores] = vl_ubcmatch(d1, d2);

%plot the matches
%plot_match(img1, img2, f1, f2, matches);

%% RANSAC
e = 0.2; %0.2
s = 2; %
p = 0.999;
delta = 5;
n = 2; %because we chose 2 feature points 
%determine k value to run k trials
k = log(1 - p) / log( 1 - (1 - e)^n );

%round k to make sure we have a whole number of iterations
k = round(k);

%a variable to store the max number of inliers
maxInliers = -99999;

%initialize the best tx and ty's
best_tx = 0;
best_ty = 0;

%iterate k times
for i = 1 : k
    
    %randomly choose a pair of features
    randPairIndices = randperm(size(matches, 2));
    
    %grab the values for rand pair chosen
    p1 = f1(1:2, matches(1, randPairIndices(1)));
    p2 = f2(1:2, matches(2, randPairIndices(1)));
    
    %compute tx_0 and ty_0
    tx_0 = p1(1) - p2(1);
    ty_0 = p1(2) - p2(2);
    
    %initialize the number of inliers to be zero
    inliers = 0;
    
    %iterate over the other N -1 pairs
    for j = 2 : size(matches, 2)
        
        %grab the current pair
        p1 = f1(1:2, matches(1, randPairIndices(j)));
        p2 = f2(1:2, matches(2, randPairIndices(j)));
        
        %compute the current tx and ty vale 
        tx = p1(1) - p2(1);
        ty = p1(2) - p2(2);
        
        %check if current tx and ty are inliers of tx_0 and ty_0
        
        %generate indicator variable 
        indicator = (tx - tx_0)^2 + (ty - ty_0)^2;
        
        %check if the indicator is less than delta
        if indicator < delta
            
            %it is an inlier, increment count
            inliers = inliers + 1;
            
        end
        
    end 
    
    %check if this tx_0 and ty_0 has more outliers than max found
    if inliers > maxInliers
        
        %update max inliers
        maxInliers = inliers;
        
        %update the best tx and ty 
        best_tx = tx_0;
        best_ty = ty_0;
        
    end
              
end





%% Stitching
tx = round(best_tx);
ty = round(best_ty);

H = size(img1, 1);
W = size(img1, 2);

output = zeros(H + ty, W + tx, 3);
output(1:H, 1:W, :) = img1;

for y2 = 1:size(img2, 1)
    for x2 = 1:size(img2, 2)
    
        y1 = y2 + ty;
        x1 = x2 + tx;
        
        if y1 >= 1 && y1 <= H + ty && x1 >= 1 && x1 <= W + tx
            output(y1, x1, :) = img2(y2, x2, :);
        end
        
    end
end

figure, imshow(output);
imwrite(output, 'result.png');
