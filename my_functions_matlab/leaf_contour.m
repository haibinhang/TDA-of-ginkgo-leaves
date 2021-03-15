% Find the polygon contour of leaf
% and remove the non-majority loops
function C = leaf_contour(BW)

    C = imcontour(BW,1);
    
    while(C(2,1)<0.3*size(C,2))
        C = C(:, C(2,1)+2:size(C,2));
    end
    
    %if C(2,1)>=0.49*size(C,2)
    
    C = C(:, 1:C(2,1)+1);
    
    if size(C,2)==C(2,1)+1
        C = C(:,2:end);
    else
        fprintf("Error: Multiple contours appear!");
    end
end