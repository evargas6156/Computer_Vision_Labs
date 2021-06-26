function [output, match]= template_matching_normcorr(img, template, threshold)

%calculate the shift based on the template
shift_u = (size(template, 2));
shift_v = (size(template, 1));

%initialize the output 
output = zeros(size(img));
match = zeros(size(img));

%make the template into a vector
template = reshape(template, 1, []);

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
        
        %convert the patch to a vector
        patch = reshape(patch, 1, []);
        
        %calculate Patch''
        pPrime = patch - mean(mean(patch)); %subtract mean
        pDoublePrime = pPrime ./ norm(reshape(pPrime, 1, [])); %normalize vector 
        
        %calculate h''
        hPrime = template - mean(mean(template)); %subtract mean
        hDoublePrime = hPrime ./ norm(reshape(hPrime, 1, [])); %normalize vector
        
        % Normalized cross-correlation is now the dot product of
        %Patch'' and h''
        value = dot(pDoublePrime, hDoublePrime);
        output(v, u) = value;
    end
end

match = (output > threshold);