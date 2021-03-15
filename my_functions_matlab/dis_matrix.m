function Matrix = dis_matrix(bar_length,method)
% Calculate distance matrix by using given method
    l = length(bar_length);
    Matrix = zeros(l,l);

    if strcmp(method,'L1_distance')
        for i = 1:l
            for j = 1:i-1
                Matrix(i,j) = Matrix(j,i);
            end
            for j = i+1:l
                Matrix(i,j) = L1_distance(bar_length{i},bar_length{j});        
            end
        end
    else
        printf('No such method found!');
    end

end