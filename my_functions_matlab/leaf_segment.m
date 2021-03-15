%   Given image "I", this function resize the image according to the 
%   'Scale' and return its 2-valued gray scale image.
function BW = leaf_segment(I,Scale)
    I = I(:,:,3);   % Here the reason that we choose the third layer of 
                    % image is that the leaf is green
                    % and the background of image is white
    I = im2double(I);
    I = imresize(I, Scale);
    level = graythresh(I);
    
    BW = imbinarize(I,level);
    BW = im2double(BW);
end