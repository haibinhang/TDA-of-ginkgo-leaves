% Draw all leaves in specified range

function branch_draw(D, X, scale, range, color)
axis equal;
for ii = range
    center = mean(D{ii}(:,2:end),2);
    D{ii} = D{ii}-center;
    leaf = X(:,ii)+scale*D{ii};
    plot(leaf(1,:),leaf(2,:),'-','Markersize',0.001,'color',color);
    hold on;
end
hold off;
end