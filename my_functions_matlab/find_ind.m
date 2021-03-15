function [BW,ind] = find_ind(BW,box)
    % remove the stem and find the index point
    Total = (2*box+1)^2;
    s = size(BW);
    ind = [0;500];
    %N = zeros(s);

    for i = (1+box):(s(1)-box)
        for j = (1+box):(s(2)-box)
            if BW(i,j) == 0.0
                Sum = Total;
                for k = -box:box
                    for l = -box:box
                        Sum = Sum-BW(i+k,j+l);
                    end
                end
                
                %N(i,j) = Sum/Total;
                
                if Sum/Total <0.19
                    BW(i,j) = 1.0;
                end
                
                if Sum/Total >= 0.19 && Sum/Total <= 0.23
                    ind(1) = i;
                    ind(2) = j;
                end
            end
        end
    end
end