function output = find_local_maxs(R)

%make the output the same size as the input
output = zeros(size(R));

for u = 2 : size(R, 2) - 1
   for v = 2 : size(R, 1) - 1
       %variables to store dimensions
       x1 = u - 1;
       x2 = u + 1;
       y1 = v - 1;
       y2 = v + 1;
       
       %ensure dimesions are in correct range
       if x1 < 1
           x1 = 1;
       end
       if x2 > size(R, 2)
           x2 = size(R, 2);
       end
       if y1 < 1
           y1 = 1;
       end
       if y2 > size(R, 1)
           y2 = size(R, 1);
       end
        
       %extract patch using sanitized dimensions 
       patch = R(y1:y2, x1:x2);

       isMax = true;
       
       centerPoint = patch(2, 2);
       
       for i = 1 : 3
           for j = 1 : 3
               
               if (patch(j, i) >= centerPoint) && (2 ~= i && 2 ~= j)
                    isMax = false; 
                    break;
               end
               
           end
           
           if isMax == false
               break;
           end
          
       end
       
       if isMax
            output(v, u) = 1;
       else
            output(v, u) = 0;
       end
        
   end
end

end