
%read in the desired image
img = im2double(imread('lena.jpg'));

%% Sobel filter

%horizontal edge filter 
H0 = [1, 2, 1; 0, 0, 0; -1, -2, -1]; 

%vertixal edge filter
H1 = [1, 0, -1; 2, 0, -2; 1, 0, -1]; 

%create and write horizontal/vertical sobel image using my function
img_sobel_horizontal = sobel_filter(img, H0); 
img_sobel_vertical = sobel_filter(img, H1); 
imwrite(img_sobel_horizontal, 'sobel_h.jpg');
imwrite(img_sobel_vertical, 'sobel_v.jpg');

%create images to compare to, using built in function
img_sobel_horizontal_real = imfilter(img, H0);
img_sobel_vertical_real = imfilter(img, H1);

%display the control images and my images to compare
figure, imshow(img_sobel_horizontal_real);
figure, imshow(img_sobel_horizontal);
figure, imshow(img_sobel_vertical_real);
figure, imshow(img_sobel_vertical);

%% Gaussian Filter

%create gaussian kernels to pass as arguments 
hsize_5 = 5; sigma_5 = 2;
hsize_9 = 9; sigma_9 = 4;

%create, display, and write image with hsize = 5, sigma = 2
img_gaussian_5 = gaussian_filter(img, hsize_5, sigma_5);
figure, imshow(img_gaussian_5);
imwrite(img_gaussian_5, 'gaussian_5.jpg');


%create, display, and write image with hsize = 9, sigma = 4
img_gaussian_9 = gaussian_filter(img, hsize_9, sigma_9);
figure, imshow(img_gaussian_9);
imwrite(img_gaussian_9, 'gaussian_9.jpg');