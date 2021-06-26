function output = gaussian_filter(img, hsize, sigma)
%create the kernel to use for the given Gaussian
H = fspecial('gaussian', hsize, sigma);

%make an image using H using built in function to compare against, display
control_image = imfilter(img,H);
figure, imshow(control_image);

%call sobel filter function using H generated above to make output image
output = sobel_filter(img, H);

end
