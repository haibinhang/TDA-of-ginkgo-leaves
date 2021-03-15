function [stream, M] = flow_complex(disFuc)
% Biuld the grid complex
    import edu.stanford.math.plex4.*;
    stream = api.Plex4.createExplicitSimplexStream();

    [h,w] = size(disFuc);
    
    M = max(max(disFuc));
    if M ~= M
        disFuc = zeros(size(disFuc));
        M = 0;
    else
        disFuc = M*ones(size(disFuc))-disFuc;
    end
    
    for i = 1:h
        for j = 1:w
            stream.addVertex(h*j-h+i,disFuc(i,j));
        end
    end
    
    for i = 1:h-1
        for j = 1:w-1
            stream.addElement([h*j-h+i,h*j-h+i+1], max(disFuc(i,j),disFuc(i+1,j)));
            stream.addElement([h*j-h+i,h*j+i], max(disFuc(i,j+1),disFuc(i+1,j)));
        end
    end
    
    for i = 1:h-1
        stream.addElement([h*w-h+i,h*w-h+i+1], max(disFuc(i,w),disFuc(i+1,w)));
    end
    
    for j = 1:w-1
        stream.addElement([h*j,h*j+h], max(disFuc(h,j),disFuc(h,j+1)));
    end
    
    stream.finalizeStream();
end