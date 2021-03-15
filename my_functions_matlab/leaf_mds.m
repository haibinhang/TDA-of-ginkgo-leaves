function X = leaf_mds(dis_matrix)

    Class = [32 14 0 0; 48 19 10 0; 44 28 20 9; 38 30 20 9; 32 31 15 0; 23 0 0 0; 32 14 0 0];

    [Y,eigens] = cmdscale(dis_matrix);

    X = Y(:,1:2)';

    segment = {'.r','.g', '.b', '.y'};
    sum = 0;

    for i = 1: size(Class,1)
        figure('Name',sprintf('Branch %d', i));  
        for j = 1:size(Class,2)
            plot(X(1,sum+1:sum+Class(i,j)),X(2,sum+1:sum+Class(i,j)),segment{j},'MarkerSize',10);
            xlim([min(X(1,:)),max(X(1,:))]);
            ylim([min(X(2,:)),max(X(2,:))]);
            hold on;
            sum = sum+Class(i,j); 
        end
        %grid on;
        title(sprintf('Branch %d',i));
        legend('Segment 1', 'Segment 2', 'Segment 3', 'Segment4')
        hold off;
    end
end
    