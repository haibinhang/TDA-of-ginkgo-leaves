function dis = L1_distance(s1,s2)
    s1 = reshape(sort(s1,'descend'),1,[]);
    s2 = reshape(sort(s2,'descend'),1,[]);
    
    if length(s1)<length(s2)
        v = s1;
        s1 = s2;
        s2 = v;
    end
    
    s2 = [s2,zeros(1,length(s1)-length(s2))];

    dis = sum(abs(s2-s1));
end