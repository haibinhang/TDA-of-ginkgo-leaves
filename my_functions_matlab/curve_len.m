% Returns the length of curve in (pixel coordinate) Euclidean distance 
function len = curve_len(C)
len = 0;
for i = 2:size(C,2)
    len = len+sqrt(sum(C(:,i)-C(:,i-1)).^2);
end