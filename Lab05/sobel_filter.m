function output = sobel_filter(img, kernel)

%make the output the same size as the input
output = zeros(size(img));

for u = 1 + size(kernel, 2) : size(img, 2) - size(kernel, 2)
   for v = 1 +size(kernel, 1) : size(img, 1) - size(kernel, 1)
       %variables to store dimensions
       x1 = u - ((size(kernel, 2) - 1) / 2);
       x2 = u + ((size(kernel, 2) - 1) / 2);
       y1 = v - ((size(kernel, 1) - 1) / 2);
       y2 = v + ((size(kernel, 1) - 1) / 2);
       
       %ensure dimesions are in correct range
       if x1 < 1
           x1 = 1;
       end
       if x2 > size(img, 2)
           x2 = size(img, 2);
       end
       if y1 < 1
           y1 = 1;
       end
       if y2 > size(img, 1)
           y2 = size(img, 1);
       end
        
       %extract patch using sanitized dimensions 
       patch = img(y1:y2, x1:x2);
       value = patch .* kernel;
       
       output(v, u) = sum(sum(value));
        
   end
end

end