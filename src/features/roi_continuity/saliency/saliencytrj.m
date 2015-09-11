function saliencytrj(file, lastid, length)
% options for saliency estiomation
options.size = 512;                     % size of rescaled image
options.quantile = 1/10;                % parameter specifying the most similar regions in the neighborhood
options.centerBias = 1;                 % 1 for center bias and 0 for no center bias
options.modeltype = 'CovariancesOnly';  % 'CovariancesOnly' and 'SigmaPoints'
                                        % to denote whether first-order statistics
					% will be incorporated or not

THRE = 0.000001;
outfile = strcat(file, '.sal.feat');
fid = fopen(outfile, 'a');
%for i = [(lastid - length + 1):lastid 1]
for i = [(lastid - length + 1):lastid]
  % Visual saliency estimation with covariances only
  imfile = strcat(file,'/',num2str(i),'.png');
  salmap1 = saliencymap(imfile, options);

  % calc centroids
  ysum = sum(salmap1, 1);
  xsum = sum(salmap1, 2);
  x = 1:size(ysum,2);
  y = 1:size(xsum,1);
  norm = sum(ysum);
  xs = ysum * x';
  ys = y * xsum;
  cx = xs / norm;
  cy = ys / norm;
  %write feature
  fprintf(fid, '%d %f %f\n', i, cx, cy);

  %save saliency
  %% if you need to save image, please uncomment below three lines.
  % gray = mat2gray(salmap1);
  % imout = strcat(file,'/',num2str(i),'.sal.png');
  % imwrite(gray,imout);
end
fclose(fid);
%salmap1_thre = (salmap1 >= THRE).*(salmap1) + (salmap1 < THRE).*(0)
%dlmwrite(imout, salmap1, 'delimiter', '\t', 'precision', 6);
% Visual saliency estimation with covariances and means
% options.modeltype = 'SigmaPoints';
% salmap2 = saliencymap('fish.png', options);

% Display results
% im = imread('fish.png');
% subplot(131);
% imagesc(im); colormap(gray); axis image off;
% title('Input image');

% subplot(132);
% imagesc(salmap1); colormap(gray); axis image off;
% title('Covariances only');

% subplot(133);
% imagesc(salmap2); colormap(gray); axis image off;
% title('Covariances and means');

% close all;
clear all;
exit;
