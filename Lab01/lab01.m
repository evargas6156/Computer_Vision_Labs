
%read in the 6 images and store them
image01 = imread('01.jpg');
image02 = imread('02.jpg');
image03 = imread('03.jpg');
image04 = imread('04.jpg');
image05 = imread('05.jpg');
image06 = imread('06.jpg');

%TASK 1-------------------------------------------------------

%save a copy of image 01 to edit
task1Image = image01;

%set the green channel equal to zero
task1Image(:, :, 2) = 0;

%save the image 
imwrite(task1Image, 'green.jpg');


%TASK 2-------------------------------------------------------

%modify image to grayscale using y=0.299×𝑅 + 0.587×𝐺 + 0.114×𝐵
task2Image = 0.299 * image01(:, :, 1) + 0.587 * image01(:, :, 2) + 0.114 * image01(:, :, 3);

%save the image 
imwrite(task2Image, 'gray.jpg');


%TASK 3-------------------------------------------------------

%rotate the image 90 degrees counterclockwise
task3Image = imrotate(image01, 90); 

%save the image 
imwrite(task3Image, 'rotate.jpg');

%TASK 4-------------------------------------------------------

%crop the image using the upper left (30, 100) and lower right (270, 300)
task4Image = image01(30:270, 100:300, :);

%save the image 
imwrite(task4Image, 'crop.jpg');


%TASK 5-------------------------------------------------------

%save a copy of image 01 to edit
task5Image = flip(image01, 2);

%save the image 
imwrite(task5Image, 'flip.jpg');

%TASK 6-------------------------------------------------------

%initialize the matriz necessary for the collage
task6Image = zeros(300 * 2 + 10, 400 * 2 + 10, 3, 'uint8');

%add the images to the appropriate submatrix
task6Image(1:300, 1:400, :) = image01;
task6Image(1:300, 411:810, :) = image02;
task6Image(311:610, 1:400, :) = image03;
task6Image(311:610, 411:810, :) = image04;

%save the image 
imwrite(task6Image, 'combine.jpg');


%TASK 7-------------------------------------------------------

%convert image 5 and 6 into a vector 
vector05 = image05(:);
vector06 = image06(:);

%take the average of both and save it to the answer vector
ansvector = (vector05 + vector06) / 2;

%reshape answer vector into an image and save it
task7Image = reshape(ansvector, 375, 1242, 3);
imwrite(task7Image, 'average.jpg');

%figure, imshow(image05)
%figure, imshow(image06)
%figure, imshow(task7Image)

%clean up workspace close all figures and clear variables
%close all;
clear;