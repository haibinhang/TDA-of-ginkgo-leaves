function dis = point2set(x,I)
% find the distance from x to a set represented by pixels with value 1 in I
[h,w] = size(I);
r = ceil(sqrt(h^2+w^2));
table = lookup(r);
if I(x(1),x(2))==1
    dis = 0;
else
    J = zeros(2*r+h,2*r+w);
    J(r+1:r+h,r+1:r+w) = I;
    B = J(x(1):x(1)+2*r,x(2):x(2)+2*r);
    if B.*table == zeros(size(B))
        dis = sqrt(h^2+w^2);
    else
        dis = sqrt(min(table(B.*table>0)));
    end
end

end