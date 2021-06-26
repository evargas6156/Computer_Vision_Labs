function feature = multiscale_sobel_feature(img, scale)
    % initialize feature vector
    feature = [];
    
    I = img;
    for i = 1:scale
        
        % compute sobel feature
        [~, f] = sobel_feature(I); %switch position of f to grab
                                     %either [magnitude, orientation]
                                     
        
        % concatenate feature vector
        feature = cat(1, feature, f(:));
        
        % down-sample image by 2
        I = imresize(I, 0.5);
    end
end