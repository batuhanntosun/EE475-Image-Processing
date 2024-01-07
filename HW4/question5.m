% EE475 HW4
% Batuhan Tosun 2017401141
%% Question 5: IDENTIFY PATTERNS and SPECTRA

img = double(imread("Patches_cosines_digital.tif"));
img_f = fftshift(fft2(img));
mag_img_f = (abs(img_f)+eps);
log_mag_img_f = log(mag_img_f);

figure
subplot(1,2,1)
imshow(img,[])
title("Original Image")
subplot(1,2,2)
imshow(log_mag_img_f,[])
title("Log-magnitude Spectrum")
