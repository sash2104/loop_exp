function saliencytrj(file, lastid)
% options for saliency estimation
options.size = 512;                     % size of rescaled image
options.quantile = 1/10;                % parameter specifying the most similar regions in the neighborhood
options.centerBias = 1;                 % 1 for center bias and 0 for no center bias
options.modeltype = 'CovariancesOnly';  % 'CovariancesOnly' and 'SigmaPoints'
                                        % to denote whether first-order statistics
					% will be incorporated or not

THRE = 0.000001;
outfile = strcat(file, '_sal.feat');
fid = fopen(outfile, 'a');
for i = [1:lastid]
  % Visual saliency estimation with covariances only
  imfile = strcat(file,'/',num2str(i),'.png');
  salmap1 = saliencymap(imfile, options);
  gray = mat2gray(salmap1);

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
  imout = strcat(file,'/',num2str(i),'_sal.png');
  imwrite(gray,imout);
end
fclose(fid);
clear all;
exit;
