function D = interp_contour(C,Num)
    len = 0;
    l = size(C,2);
    d = zeros(1,l-1);
    for i = 1:l-1
        d(i) = sqrt(sum((C(:,i+1)-C(:,i)).^2));
        len = len+d(i);
    end
    
    segment = len/Num;
    
    D = zeros(2,Num+2);
    D(:,1) = C(:,1);
    j = 1;
    i = 1;
    while i < l
        e_part = sqrt(sum((D(:,j)-C(:,i)).^2));
        s_part = segment-e_part;
        while i < l && d(i)<s_part
            s_part = s_part-d(i);
            i = i+1;
            if i == l
                s_part = 0;
            end
        end
        if i < l
            norm = (C(:,i+1)-C(:,i))./d(i);
        else
            norm =[0;0];
        end
        
        vec = norm.*segment;
        D(:,j+1) = C(:,i)+norm.*s_part;
        j = j+1;
        if i == l
            break;
        end
        s = d(i)-s_part;
        while s>segment
            D(:,j+1) = D(:,j)+vec;
            s = s-segment;
            j = j+1;
        end
        i = i+1;
        if i == l
            D(:,j) = C(:,i);
        end
    end
    D = D(:,1:j);
end