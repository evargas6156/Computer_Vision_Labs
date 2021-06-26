function [m, b] = hough_transform(edge_map)
    
    %% find x, y position from edge map
    [edge_y, edge_x] = find(edge_map);
    
    %% range of b
    H = size(edge_map, 1);
    b_range = -H : 1 : H;
    
    %% range of m
    m_step = 0.01;
    m_max = 5;
    m_min = -m_max;
    m_range = m_min : m_step : m_max;
    
    %% create vote matrix
    V = zeros(length(m_range), length(b_range));
    
    %% TODO: add votes
    %V(1, 1) = 1;  remove this line
    
    %iterate over every x,y in the edge map
    for i = 1 : length(edge_y)
        
        %grab the current x and y value
        y = edge_y(i);
        x = edge_x(i);
        
        %iterate over all b values
        for b_index = 1 : length(b_range)
           
            %grab the current b 
            b = b_range(b_index);
            
            %calculate current m value
            m = ( ( -1 / x ) * b ) + ( y / x);
            
            %ensure m is in correct range
            if m >= m_min && m <= m_max
                
                %compute the m index 
                m_index = round( (m - m_min) / m_step ) + 1;
            
                %add the current vote to vote matrix V
                V(m_index, b_index) = V(m_index, b_index) + 1;
            end
            
        end
        
    end
    

    %% visualize votes
    figure, imagesc(V); xlabel('b'); ylabel('m'); 
    
    
    %% find the maximal vote
    max_vote = max(V(:));
    [max_m_index, max_b_index] = find( V == max_vote );
    m = m_range(max_m_index);
    b = b_range(max_b_index);

end