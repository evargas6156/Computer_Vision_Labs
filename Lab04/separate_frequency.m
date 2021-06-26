function[low_pass_img, high_pass_img] = separate_frequency(img, ratio)

%% apply FFT
frequency_map = fft2(img);

%display the frequency map after fft for debugging purposes 
%figure, imshow(log(abs(frequency_map) + 1), []); 

%% shift the frequency map
shifted_frequency_map = fftshift(frequency_map);

%display the shifted frequency map after shifting for debugging purposes 
figure, imshow(log(abs(real(shifted_frequency_map)) + 1), []); 

%% compute low frequency mask

%calculate the height and width of the mask given the ratio 
if ratio < 1.0
    widthImage = size(img, 2);
    heightImage = size(img, 1);
    heightMask = ratio * heightImage;
    widthMask = ratio * widthImage;
    y1 = (heightImage / 2) - (heightMask / 2);
    y1 = cast(y1, 'int32');
    y2 = (heightImage / 2) + (heightMask / 2);
    y2 = cast(y2, 'int32');
    x1 = (widthImage / 2) - (widthMask / 2);
    x1 = cast(x1, 'int32');
    x2 = (widthImage / 2) + (widthMask / 2);
    x2 = cast(x2, 'int32');
else
   y1 = 1;
   x1 = 1;
   y2 = size(img, 1);
   x2 = size(img, 2);
end
mask = zeros(size(img));
mask(y1 : y2, x1 : x2, :) = 1;
% print the mask for debugging purposes 
%figure, imshow(mask);

%% separate low frequency and high frequency maps
shifted_low_frequency_map = shifted_frequency_map .* mask;
shifted_high_frequency_map = shifted_frequency_map .* (1 - mask);
%print the maps for debugging purposes 
%figure, imshow(log(abs(real(shifted_low_frequency_map)) + 1), []);
%figure, imshow(log(abs(real(shifted_high_frequency_map)) + 1), []);

%% shift frequency maps back
low_frequency_map = ifftshift(shifted_low_frequency_map);
high_frequency_map = ifftshift(shifted_high_frequency_map);
%print the high and low frequency maps for debugging purposes
%figure, imshow(log(abs(low_frequency_map) + 1), []);
%figure, imshow(log(abs(high_frequency_map) + 1), []);

%% apply Inverse FFT
low_pass_img = real(ifft2(low_frequency_map));
high_pass_img = real(ifft2(high_frequency_map));

%print final image for debugging purposes add 0.5 to high freq to better
%visualize 
%figure, imshow(low_pass_img);
%figure, imshow(high_pass_img + 0.5);



end