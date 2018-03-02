% k-means segmentation experiments
% Author: Jin Yeom (jinyeom@utexas.edu)

% Test images.
I = im2double(imread('images/gumballs.jpg'));
J = im2double(imread('images/twins.jpg'));
K = im2double(imread('images/snake.jpg'));
L = im2double(imread('images/car.jpg'));

% Parameters to be tuned.
k = 12;
winSize = 65;
numColorRegions = 12;
numTextureRegions = 12;

% Load the filter bank.
load('data/filterBank.mat', 'F');
fprintf('filterBank dimensions: (%s)\n', num2str(size(F)))
displayFilterBank(F)

% Create a stack of images for creating textons.
% This image stack consists of the test images above in grayscale, with the
% dimensions of the first image.
S = rgb2gray(I);
S = imstack(S, J);
S = imstack(S, K);
S = imstack(S, L);
fprintf('imStack dimensions: (%s)\n', num2str(size(S)))

stacksize = size(S, 3);
imsize = ceil(sqrt(stacksize));

figure;
for i = 1:stacksize
  subplot(imsize, imsize, i);
  imagesc(S(:, :, i));
end
saveas(figure, 'images/imstack.pdf')

% Generate textons
% This texton matrix should have the dimensions of (k, d), where k is the
% number of clusters, and d is the number of filters (or edge features), e.g.,
% if there are 10 clusters and 38 filters in the filter bank, the dimensions of
% textons should be (10, 38).
T = createTextons(S, F, k);
fprintf('textons dimensions: (%s)\n', num2str(size(T)))

% Now for the experiments...
[colorLabelIm, textureLabelIm] = ...
  compareSegmentations(I, F, T, winSize, numColorRegions, numTextureRegions);
figure;
title('Gumballs (color vs texture)')
subplot(1, 2, 1); imagesc(colorLabelIm);
subplot(1, 2, 2); imagesc(textureLabelIm); 
saveas(figure, 'images/gumballs_results.pdf');
disp('Gumballs figure saved.')

[colorLabelIm, textureLabelIm] = ...
  compareSegmentations(J, F, T, winSize, numColorRegions, numTextureRegions);
figure;
title('Twins (color vs texture)')
subplot(1, 2, 1); imagesc(colorLabelIm);
subplot(1, 2, 2); imagesc(textureLabelIm); 
saveas(figure, 'images/twins_results.pdf')
disp('Twins figure saved.')

[colorLabelIm, textureLabelIm] = ...
  compareSegmentations(K, F, T, winSize, numColorRegions, numTextureRegions);
figure;
title('Snake (color vs texture)')
subplot(1, 2, 1); imagesc(colorLabelIm);
subplot(1, 2, 2); imagesc(textureLabelIm); 
saveas(figure, 'images/snake_results.pdf');
disp('Snake figure saved.')

[colorLabelIm, textureLabelIm] = ...
  compareSegmentations(L, F, T, winSize, numColorRegions, numTextureRegions);
figure;
title('Car (color vs texture)')
subplot(1, 2, 1); imagesc(colorLabelIm);
subplot(1, 2, 2); imagesc(textureLabelIm); 
saveas(figure, 'images/car_results.pdf')
disp('Car figure saved.')
