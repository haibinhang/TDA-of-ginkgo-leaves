function [] = leaf_draw(X,D)
   
    for ii = 1: size(X,2)
        a = floor(X(1,ii)/5);
        b = floor(X(2,ii)/5);
        h=figure('visible','off');
        plot(D{ii}(1,2:size(D{ii},2)),D{ii}(2,2:size(D{ii},2)));
        daspect([1 1 1])
        hold on
        plot(D{ii}(2,1),D{ii}(1,1),'x');
        hold off
        folder = sprintf('%dx%d',a+2,b+2);
        folder = fullfile('C:\Users\haibi\Documents\matlab_examples\Ginkgo_leaf',sprintf('data_%d',interval_num(k)),folder);
        if exist(folder,'dir')
            pass;
        else
            mkdir(folder);
        end
        path = fullfile(folder,sprintf('%d.jpg',ii));
        saveas(h,path);
    end
end