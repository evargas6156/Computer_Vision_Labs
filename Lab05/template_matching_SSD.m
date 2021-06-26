function [output, match]= template_matching_SSD(img, template, threshold)

%calculate the shift based on the template
shift_u = (size(template, 2));
shift_v = (size(template, 1));

%initialize the output 
output = zeros(size(img));
match = zeros(size(img));

for u = 1 + shift_u : size(img, 2) - shift_u
    for v = 1 + shift_v : size(img, 1) - shift_v
       x1 = u - ((shift_u - 1) / 2);
       x2 = u + ((shift_u - 1) / 2);
       y1 = v - ((shift_v - 1) / 2);
       y2 = v + ((shift_v - 1) / 2);
       
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
        
        %grab the patch using the sanitized dimensions 
        patch = img(y1:y2, x1:x2);
        
        % SSD
        value = (template - patch).^2;
        output(v, u) = sum(sum(value));
    end
end

match = (output < threshold);