% Read in the images and store them

image01 = im2double(imread('01.jpg'));
image = im2double(imread('lena_noisy.jpg'));

% Task 1-----------------------------------------------------------
% rotate 01.jpg by 45 degrees using forward warping
task1Image = zeros(size(image01));
%get pixel size of the image
sizeX = size(image01,2);
sizeY = size(image01,1);
%iterate over all pixels
for y = 1:sizeY
    for x = 1:sizeX
        %calculate the rotated position
        newX = cosd(45) * (x - 200) + sind(45) * (y - 150) + 200;
        newY = -sind(45) * (x - 200) + cosd(45) * (y - 150) + 150;
        %polish the position by casting it to an integer
        finalX = (cast(newX, 'int32'));
        finalY = (cast(newY, 'int32'));
        %if the position is valid, put it on the image
        if finalX <= sizeX && finalY <= sizeY && finalX > 0 && finalY > 0
            task1Image(finalY, finalX , :) = image01(y, x, :);
        end
    end
end

%write the image
imwrite(task1Image, 'rotate_0.jpg');

%print image for debugging
%figure, imshow(task1Image);

% Task 2-----------------------------------------------------------
% rotate 01.jpg by 45 degrees using backward warping
task2Image = task1Image;
correctImage = imrotate(image01, 45, 'nearest', 'crop');
%iterate over all pixels
for y = 1:sizeY
    for x = 1:sizeX
        %calculate the rotated position
        newX = cosd(45) * (x - 200) + (-1 * sind(45)) * (y - 150) + 200;
        newY = sind(45) * (x - 200) + cosd(45) * (y - 150) + 150;
        %polish the position by casting it to an integer
        finalX = (cast(newX, 'int32'));
        finalY = (cast(newY, 'int32'));
        %if the position is valid, put it on the image
        if finalX <= sizeX && finalY <= sizeY && finalX > 0 && finalY > 0
            task2Image(y, x , :) = image01(finalY, finalX, :);
        end
    end
end

%write the image
imwrite(task2Image, 'rotate_1.jpg');

%print image for debugging
%figure, imshow(task2Image);

%Task 3-----------------------------------------------------
% Median filter
patch_size_0 = [3, 3];
patch_size_1 = [5, 5];

%run the median filter for both patch sizes
img_median_0 = median_filter(image, patch_size_0);
img_median_1 = median_filter(image, patch_size_1);

%save both images 
imwrite(img_median_0,'median_0.jpg');
imwrite(img_median_1,'median_1.jpg');

%display images and the built in function images for debugging
%figure, imshow(img_median_0)
%I = medfilt2(image , patch_size_0);
%figure, imshow(I)

%figure, imshow(img_median_1)
%I2 = medfilt2(image , patch_size_1);
%figure, imshow(I2)



