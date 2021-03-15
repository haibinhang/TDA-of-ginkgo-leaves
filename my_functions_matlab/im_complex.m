function [stream, M] = im_complex(image)
% Biuld the grid complex
    import edu.stanford.math.plex4.*;
    stream = api.Plex4.createExplicitSimplexStream();

    [h,w] = size(image);
    
    M = max(max(image));
%     if M ~= M
%         image = zeros(size(image));
%         M = 0;
%     else
%         image = M*ones(size(image))-image;
%     end
    for i = 1:h
        for j = 1:w
            stream.addVertex(h*j-h+i,image(i,j));
        end
    end
    
    for i = 1:h-1
        for j = 1:w-1
            stream.addElement([h*j-h+i,h*j-h+i+1], max(image(i,j),image(i+1,j)));
            stream.addElement([h*j-h+i,h*j+i], max(image(i,j+1),image(i+1,j)));
        end
    end
    
    for i = 1:h-1
        stream.addElement([h*w-h+i,h*w-h+i+1], max(image(i,w),image(i+1,w)));
    end
    
    for j = 1:w-1
        stream.addElement([h*j,h*j+h], max(image(h,j),image(h,j+1)));
    end
    
    stream.finalizeStream();
end