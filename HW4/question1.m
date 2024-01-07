% EE475 HW4
% Batuhan Tosun 2017401141
%% Question 1: Moire Noise Removal

N_fft = 1024;
img = double(imread("car-moire-pattern.tif"));
img_f = fftshift(fft2(img));
mag_img_f = abs(img_f);
log_mag_img_f = log(mag_img_f+eps);

figure
imshow(img,[])

%%
figure
subplot(1,2,1)
imshow(mag_img_f,[])
title("Magnitude Spectrum")
subplot(1,2,2)
imshow(log_mag_img_f,[])
title("Log-Magnitude Spectrum")

minValue = min(min(log_mag_img_f));
maxValue = max(max(log_mag_img_f));

%%
figure
subplot(1,2,1)
imshow(log_mag_img_f,[])
title("Log-Magnitude Spectrum")
subplot(1,2,2)
amplitudeThreshold = 10;
brightSpikes = log_mag_img_f > amplitudeThreshold; % Binary image.
imshow(brightSpikes);
title("Thresholded Log-Magnitude Spectrum")
%%
figure
brightSpikes(110:143, :) = 0;
brightSpikes(:, 70:94) = 0;
imshow(brightSpikes);
title("Resulting Binary Image")

figure
imagesc(brightSpikes)
title("Resulting Binary Image")

figure
mesh(brightSpikes)
%%
uv = [58 86; 58 167; 113,83; 114,163; 56,44; 112,44; 58,209; 115,203];

rad = [9,9,9,9,5,5,5,5];

moire_pattern_f = img_f;
filtered_img_f= img_f;
for k=1:8
    u_dist = uv(k,2);
    v_dist = uv(k,1);
    radi = rad(k);
    
    H = myNotchFilter(img, radi, u_dist,v_dist);

    
    moire_pattern_f = moire_pattern_f.*(1-H);
    filtered_img_f = filtered_img_f.*H;
end

figure
subplot(1,2,1)
imshow(log(filtered_img_f),[])
title("After Notch Filter: Removed")
subplot(1,2,2)
moirePattern = abs(ifft2(fftshift(moire_pattern_f)));
imshow(moirePattern,[])
title("Moire Pattern")

figure
subplot(1,2,1)
filteredImage = abs(ifft2(fftshift(filtered_img_f)));
imshow(filteredImage,[])
title("Notch Filtered Image")
subplot(1,2,2)
moirePattern = abs(ifft2(fftshift(moire_pattern_f)));
imshow(moirePattern,[])
title("Moire Pattern")

%%

function H = myNotchFilter(img, radius, distance_u,distance_v)
    
n = 4;    
[M,N] = size(img);
 
u = 0:(M-1);
v = 0:(N-1);
%midU = ceil(M/2);
%midV = ceil(N/2);
u = u - distance_u +1;
v = v - distance_v +1; 

[V, U] = meshgrid(v,u);
D = sqrt(U.^2 + V.^2);
H = 1-1./(1 + (D./radius).^(2*n));


end


