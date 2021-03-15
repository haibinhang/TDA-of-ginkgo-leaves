function plot_in_plot(D,X,scale,position,V_0,diameter,V_1,Scale,color)
x_0 = V_0(1);
y_0 = V_0(2);
x_1 = V_1(1);
y_1 = V_1(2);
start = position(1);
ends = position(2);

d = diameter*Scale;
s = [x_0,x_0,x_0-diameter,x_0-diameter,x_0];
t = [y_0,y_0-d,y_0-d,y_0,y_0];
hold on
plot([x_0,x_0,x_0-diameter,x_0-diameter,x_0],[y_0,y_0-diameter,y_0-diameter,y_0,y_0],'-','color','k');
plot([x_1+d,x_1+d,x_1,x_1,x_1+d],[y_1+d,y_1,y_1,y_1+d,y_1+d],'-','Markersize',1,'color','k');
plot([x_0,x_1],[y_0,y_1],'-','Markersize',2,'color','k');

for ii = start:ends
    center = mean(D{ii}(:,2:end),2);
    D{ii} = D{ii}-center;
    leafs = X(:,ii)+scale*D{ii};
    a = min(leafs,[],2);
    c = max(leafs,[],2);
    if (a(1)>x_0-diameter) && (c(1)<x_0) && (a(2)>y_0-diameter) && (c(2)<y_0) 
        Leaf = V_1 + (leafs-V_0+[diameter;diameter])*Scale;
        hold on
        plot(Leaf(1,:),Leaf(2,:),'-','Markersize',0.01*Scale,'color',color);
    end
end
