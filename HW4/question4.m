% EE475 HW4
% Batuhan Tosun 2017401141
%% Question 4: DEBLURRING

img = double(imread("book-cover.tif"));

% parts a&b atmospheric turbulence and gaussian noise adding
img_f = fftshift(fft2(img));
H = myAtmosphericTurbulence(img,false);
H_img_f = img_f.*H;
h_img = uint8(abs(ifft2(fftshift(H_img_f))));
noise_h_img = imnoise(uint8(h_img),'gaussian',0,625/255^2);

figure
subplot(1,2,1)
imshow(uint8(img))
title("Original Image")

subplot(1,2,2)
imshow(uint8(noise_h_img))
title("Blurred & Noisy Version")

%% part c : inverse filter and inverse filter with butterworth lpf

noise_H_img_f = fftshift(fft2(double(noise_h_img)));
H_butter = my2DButterworth(img);
H_inv = 1./(H+eps);
figure
imagesc(H_inv)

filt_img_f = noise_H_img_f.*H_inv;
filt_lpf_img_f = filt_img_f.*H_butter;

filt_img = abs(ifft2(ifftshift(filt_img_f)));
filt_lpf_img = abs(ifft2(ifftshift(filt_lpf_img_f)));


figure
subplot(1,2,1)
imshow(uint8(rescale(filt_img,0,255)),[])
title("After Only Inverse Filter")
subplot(1,2,2)
imshow(uint8(rescale(filt_lpf_img,0,255)),[])
title("After Inverse Filter with Butterworth LPF")

%% part d : inverse filter and wiener filter

gauss_noise = double(noise_h_img) - double(h_img);
gauss_noise_f = fftshift(fft2(gauss_noise));

%K = 0.06;

K = (abs(gauss_noise_f).^2)./(abs(img_f).^2);

W_h = (1./(H+eps)).*(abs(H.^2))./(abs(H.^2)+K);

noise_w_img_f = noise_H_img_f.*W_h;
filt_w_img = real(ifft2(fftshift(noise_w_img_f)));

figure
subplot(1,2,1)
imshow(uint8(rescale(filt_img,0,255)),[])
title("After Only Inverse Filter")
subplot(1,2,2)
imshow(uint8(rescale(filt_w_img,0,255)),[])
title("After Only Wiener Filter")


%%
function H = myAtmosphericTurbulence(img, inverse)

[M,N] = size(img);

midY = ceil(M/2);
midX = ceil(N/2);

H = zeros(M,N);
% degradation constant
if inverse
    k = -0.0025;
else
    k = 0.0025;
end

for i = 1:1:M
    for j = 1:1:N
        nominator = (i - midY)^2 + (j - midX)^2;
        H(i,j) = exp(-k*((nominator)^(5/6)));
    end
end
end

function H = my2DButterworth(img)
    
n = 10;    
radius = 50;
[M,N] = size(img);
 
u = 0:(M-1);
v = 0:(N-1);
midU = ceil(M/2);
midV = ceil(N/2);
u = u - midU+1;
v = v - midV+1;

[V, U] = meshgrid(v,u);
D = sqrt(U.^2 + V.^2);
H = 1./(1 + (D./radius).^(2*n));
figure
imagesc(H)
H = H + eps;
end