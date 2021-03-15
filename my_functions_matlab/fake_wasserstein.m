function fval = fake_wasserstein(s1,s2)

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
    
    beq = [s1,s2];
    
    f = zeros(L1,L2);
    for i = 1:L1
        for j = 1:L2
            f(i,j) = abs(s1(i)-s2(j));
        end
    end
    f = [f, ones(L1,1); ones(1,L2), 0];
    f = reshape(f,1,[]);
    options = optimset('linprog');
    options.Display = 'off';
    [x, fval] = linprog(f,[],[],Aeq,beq,zeros(1,(L1+1)*(L2+1)),[],options);
end