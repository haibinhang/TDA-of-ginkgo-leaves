function table = lookup(square)
A = zeros(2*square+1,2*square+1);
for i = 1:2*square+1
    A(i,:) = ones(1,2*square+1).*(i-square-1);
end
table = A.^2 + A'.^2;
end