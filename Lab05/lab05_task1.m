%import image 
img = im2double(imread('lena.jpg'));

sigma = 2.0;
hsize = 7;
scale = 5;

%% Task 1 - Gaussian Pyramid
I = img;

for s = 1 : scale
    
    %get the appropriate kernel to use for a gausssian
    H = fspecial('gaussian', hsize, sigma);
    
    %run the gaussuan filter using the kernel
    I = imfilter(I, H);
    
    %save and show the image
    figure
    imshow(I);
    imwrite(I, sprintf('Gaussian_scale%d.jpg', s));
    
    %down sampling 
    I = imresize(I, 0.5);
    
end

%reset I for laplacian pyramid and input temporary 
I = img;
temp = img; %stores original image but resized 

%% Task 1 - Laplacian Pyramid
for s = 1 : scale

    % Gaussian filtering
    H = fspecial('gaussian', hsize, sigma);
    gaussianImage = imfilter(I, H);
    
    % Laplacian filtering
    laplacianImage  = temp - gaussianImage;
    
    % Save and show image
    figure 
    imshow(laplacianImage + 0.5);
    imwrite(laplacianImage + 0.5, sprintf('Laplacian_scale%d.jpg',s));

    % Down sampling
    I = imresize(I, 0.5);
    temp = imresize(temp, 0.5);
    
end