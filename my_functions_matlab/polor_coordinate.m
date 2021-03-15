%% Radius transformation of the image

len = 2400*Scale; % len should be an even integer to avoid mistakes
k = pi/len;
l = 1/3;
R = zeros(len,len+1);
for radius = 0:len-1
    for angle = -len/2:len/2
        y = radius*cos(angle*k)*l;
        x = radius*sin(angle*k)*l;
        i = ind(1)-round(x);
        j = ind(2)+round(y);
        if (i>s(1) || j>s(2) || i<1 || j<1)
            R(len-radius,len/2+1+angle) = 1.0; 
        else
            R(len-radius,len/2+1+angle) = BW(i,j);
        end
    end
end
imshow(R)