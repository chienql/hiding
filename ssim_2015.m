function [mssim, ssim_map] = ssim_2015(img1, img2, K, window, L)


%% Input 
%   K = [0.01 0.03];
%   window = ones(8);
%   L = 255;
%   img1: the first image being compared
%   img2: the second image being compared
%%Output: (1) mssim: the mean SSIM index value between 2 images.
%            If img1 = img2, then mssim = 1.
%        (2) ssim_map: the SSIM index map of the test image. The actual 
%            size depends on the window size.
%%Usage:
%   [mssim, ssim_map] = ssim(img1, img2);
% 
%results:
%
%   mssim                        %Gives the mssim value
%========================================================================

[M N] = size(img1);
window = ones(8);
window = fspecial('gaussian', 11, 1.5);	%
   K = [0.01 0.03];  		
   L = 255;                     

img1 = double(img1);
img2 = double(img2);


C1 = (K(1)*L)^2;
C2 = (K(2)*L)^2;
window = window/sum(sum(window));

mu1   = filter2(window, img1, 'valid');
mu2   = filter2(window, img2, 'valid');
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(window, img1.*img1, 'valid') - mu1_sq;
sigma2_sq = filter2(window, img2.*img2, 'valid') - mu2_sq;
sigma12 = filter2(window, img1.*img2, 'valid') - mu1_mu2;

ssim_map = ((2*mu1_mu2 + C1).*(2*sigma12 + C2))./((mu1_sq + mu2_sq + C1).*(sigma1_sq + sigma2_sq + C2));
mssim = mean2(ssim_map);

return