function fval = L1_matching(s1,s2)

    s1 = reshape(s1,1,[]);
    s2 = reshape(s2,1,[]);
    L1 = length(s1);
    L2 = length(s2);
    
    Aeq = zeros(L1+L2,(L1+1)*(L2+1));
    
    for i = 1:L1
        T = zeros(L1+1,L2+1);
        T(i,:) = ones(1,L2+1);
        Aeq(i,:) = reshape(T,1,[]);
    end
    
    for i = 1:L2
        T = zeros(L1+1,L2+1);
        T(:,i) = ones(L1+1,1);
        Aeq(L1+i,:) = reshape(T,1,[]);
    end
    
    beq = ones(1,L1+L2);
    
    f = zeros(L1,L2);
    for i = 1:L1
        for j = 1:L2
            f(i,j) = abs(s1(i)-s2(j));
        end
    end
    f = [f, abs(s1'); abs(s2), 0];
    f = reshape(f,1,[]);
    x0 = [zeros(L1,L2),ones(L1,1);ones(1,L2),0];
    options = optimoptions('intlinprog');
    options.Display = 'off';
    [x, fval] = intlinprog(f,1:(L1+1)*(L2+1),[],[],Aeq,beq,zeros(1,(L1+1)*(L2+1)),ones(1,(L1+1)*(L2+1)),x0,options);
end