%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Persistent homology barcode of a ginkgo leave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% General setting
addpath('leaf_images'); % This file contains some example ginkgo images
addpath('my_functions_matlab'); % This file contains our matlab functions

%% Preprocess of ginkgo leaf image 

leaf_image = imread('B1GS2_8.jpg');

I = leaf_image(:,:,3); % Here the reason that we choose the third layer of 
                       % image is that the leaf is green
                       % and the background of leaf image is white
I = im2double(I);

Scale = 1/8;
I = imresize(I, Scale); % Resize the image to simplify computations

level = graythresh(I);      % Get the threshold value to segment image
BW = imbinarize(I, level);  % Get a binary image from image segmentation
BW = im2double(BW);

%% Find joint point between leaf and petiole

window = 64*Scale;
[BW_without_petiole, ind] = find_ind(BW, window);

%% Find the contour/boundary of leaf and compute length of petiole

figure;
subplot(1,2,1)
C = leaf_contour(BW);
subplot(1,2,2)
C1 = leaf_contour(BW_without_petiole);
PetioleLength = 0.5*(curve_len(C)-curve_len(C1));

%% Reparamitrize the contour curve
[eps, start_index] = min(sum(abs(C1-[ind(2);ind(1)])));
Contour = [C1(:,start_index:end) C1(:,2:start_index)]-C1(:,start_index);

% Interplate Contour curve (polygon) such that the vertices are evenly
% spaced
interval_num = 100; % The number of vertices in reparamitrized curve
D = interp_contour(Contour, interval_num); 

%% Compute the persistence barcode of the contour of a leaf  

% Setup parameters for persistent homology calculation using Javaplex
import edu.stanford.math.plex4.*;
Maximum_dim =1;
Prime_num_field = 2;

% Build the filtered complex in which the filtration 
% value at each vertex is its distance to joint point.
[stream, M] = leaf_complex(D); 

persistence = api.Plex4.getModularSimplicialAlgorithm(Maximum_dim, Prime_num_field);
intervals = persistence.computeIntervals(stream);
intervals_dim0 = edu.stanford.math.plex4.homology.barcodes.BarcodeUtility.getEndpoints(intervals, 0, 0);
intervals_dim0(intervals_dim0 == inf) = ceil(M);

% Plot the (0th) barcode
%options.filename = 'barcode';
options.max_filtration_value = M;
plot_barcodes(intervals, options)
