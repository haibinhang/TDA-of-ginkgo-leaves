%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Multi-dimensional scaling for a set of ginkgo leaves
%%% Compute area of each leaf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% General setting

addpath('leaf_images'); % This file contains some example ginkgo images
addpath('my_functions_matlab'); % This file contains our matlab functions

imagefiles = dir('leaf_images/*.jpg'); % The set of ginkgo leaves
nfiles = length(imagefiles);

% Count how many pixels in image equals 1cm length in reality
% This need to be done by hand
pixelDis_per_cm = (249-59)/10;

Scale = 1/8;
window = 64*Scale;
%% Get barcodes 

import edu.stanford.math.plex4.*;
Maximum_dim =1;
Prime_num_field = 2;
interval_num = 100;
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    leaf(ii).Name = currentfilename;

    image = imread(currentfilename);
    BW = leaf_segment(image, Scale);
    [BW1,ind] = find_ind(BW, window);
    C = leaf_contour(BW);
    C1 = leaf_contour(BW1);
    leaf(ii).StemLength = 0.5*(curve_len(C)-curve_len(C1));

    [eps,I] = min(sum(abs(C1-[ind(2);ind(1)])));
    leaf(ii).Contour = [C1(:,I:end) C1(:,2:I)]-C1(:,I);

    D = interp_contour(leaf(ii).Contour, interval_num);
    [stream, M] = leaf_complex(D);
    persistence = api.Plex4.getModularSimplicialAlgorithm(Maximum_dim, Prime_num_field);
    intervals = persistence.computeIntervals(stream);
    intervals_dim0 = edu.stanford.math.plex4.homology.barcodes.BarcodeUtility.getEndpoints(intervals, 0, 0);
    intervals_dim0(intervals_dim0 == inf) = ceil(M);
    leaf(ii).BarLengthCode = sort(intervals_dim0(:,2)-intervals_dim0(:,1),'descend');
end
save('leaf_data.mat','leaf');

%% Get the distance matrix by using L1_distance

bar_length_dim0 = {};
for ii = 1:length(leaf)
    bar_length_dim0{ii} = leaf(ii).BarLengthCode;
    bar_length_dim0_normed{ii} = bar_length_dim0{ii}(1:end)/bar_length_dim0{ii}(1);
end

M_dim0 = dis_matrix(bar_length_dim0,'L1_distance');
M_dim0_normed = dis_matrix(bar_length_dim0_normed,'L1_distance');

%% Multi-dimensional scaling.

[Y,eigens] = cmdscale(M_dim0);

p_eigen = eigens>0;
sum_eigen = sum(eigens(p_eigen));
h = figure;
subplot(1,2,1)
bar(eigens);
title('Eigens');
subplot(1,2,2)
bar(eigens(p_eigen)/sum_eigen);
title('Positive eigens divided by sum of positive eigens');

%% Translate all the data to recenter

X = Y(:,1:2); % Project the original data Y to its first 2 princple componets
X = X-min(X); % Recenter data points
limits = max(X);
X = X'; % Transpose the data
%% Projection plot of contours D

D = {};
for ii = 1:length(leaf)
    D{ii} = leaf(ii).Contour;
end

h = figure('Position',[0 0 600 400]);
branch_draw(D,X,0.1,[1:length(leaf)],'k');
%% Projection plot of normed contours D_normed
D_normed = {};
for ii = 1:length(leaf)
    D_normed{ii} = leaf(ii).Contour/leaf(ii).BarLengthCode(1);
end

h = figure('Position',[0 0 600 400]);
branch_draw(D,X,0.1,[1:length(leaf)],'k');

%% Compute the area of leaves

area = zeros(1,length(leaf));
for ii = 1:length(leaf)
    C = leaf(ii).Contour;
    area(ii) = polyarea(C(1,:), C(2,:));
end
