function [stream,M] = leaf_complex(D)
% Biuld the complex of the boundary of leaf
    import edu.stanford.math.plex4.*;
    stream = api.Plex4.createExplicitSimplexStream();
    s = size(D,2);
    d = zeros(1,s);
    for i = 1:s
        d(i) = sqrt(sum((D(:,i)).^2));
    end
    
    M = max(d);
    
    for i = 1:s-1
       stream.addVertex(i, M-d(i));
    end
    
    for i = 2:s-1
        stream.addElement([i-1,i], max(M-d(i),M-d(i-1)));
    end
    
    stream.addElement([s-1,1], max(M-d(s-1),M-d(1)));
    
    stream.finalizeStream();
end