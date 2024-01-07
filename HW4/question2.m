warning off;
% EE475 HW4
% Batuhan Tosun 2017401141
%% Question 2: Importance of the Phase

%% new trial for RGB

img_girl = imread("Berkeley_girl.jpg");
img_horse = imread("Berkeley_horses.jpg");

figure
subplot(1,2,1)
imshow(img_girl)
title("Berkeley girl")
subplot(1,2,2)
imshow(img_horse)
title("Berkeley horse")

img_girl_f = fft2(im2double(img_girl));
phase_girl_f = exp(1i*angle(img_girl_f));
magnitude_girl_f = abs(img_girl_f);

img_horse_f = fft2(im2double(img_horse));
phase_horse_f = exp(1i*angle(img_horse_f));
magnitude_horse_f = abs(img_horse_f);

% a: girl from only phase and only magnitude

phase_girl_img =  uint8(rescale(abs(ifft2(phase_girl_f)),0,255));
mag_girl_img =  im2uint8((abs(ifft2(magnitude_girl_f))));

figure
subplot(1,2,1)
imshow(phase_girl_img)
title("Reconstructed: Only-Phase Spectrum")
subplot(1,2,2)
imshow(mag_girl_img)
title("Reconstructed: Only-Magnitude Spectrum")


% b: horse from only phase and only magnitude

phase_horse_img =  uint8(rescale(abs(ifft2(phase_horse_f)),0,255));
mag_horse_img =  im2uint8((abs(ifft2(magnitude_horse_f))));

figure
subplot(2,1,1)
imshow(phase_horse_img)
title("Reconstructed: Only-Phase Spectrum")
subplot(2,1,2)
imshow(mag_horse_img)
title("Reconstructed: Only-Magnitude Spectrum")

% c: girl from horse’s phase spectrum and girl’s magnitude spectrum

girl_c_img = pagetranspose(ifft2((phase_horse_f).*(pagetranspose(magnitude_girl_f))));
figure
imshow(girl_c_img,[])
title("Berkeley girl from Berkeley horse’s phase & Berkeley girl’s magnitude spectrum")


% d: horse from girl’s phase spectrum and horse’s magnitude spectrum

horse_c_img = pagetranspose(ifft2((phase_girl_f).*(pagetranspose(magnitude_horse_f))));
figure
imshow(horse_c_img,[])
title("Berkeley horse from Berkeley girl’s phase & Berkeley horse’s magnitude")

% e: restore girl
phase_girl_f = flipdim(phase_girl_f,2);
girl_e_img = im2uint8(abs(ifft2((magnitude_girl_f).*(phase_girl_f))));
figure
imshow(girl_e_img,[])
title("The Reconstructed Image in Part E")


%% CONVERTED TO GRAY 
img_girl = double(rgb2gray(imread("Berkeley_girl.jpg")));
img_horse = double(rgb2gray(imread("Berkeley_horses.jpg")));
img_horse = img_horse';

%% plot the images

figure
subplot(1,2,1)
imshow(uint8(img_girl))
title("Berkeley girl")
subplot(1,2,2)
imshow(uint8(img_horse'))
title("Berkeley horses")

%% part a : reconstruct Berkeley_girl froom its phase-only, magnitude-only

img_girl_f = fft2(img_girl);
girl_phase_f = exp(1i.*angle(img_girl_f));
girl_magnitude_f = abs(img_girl_f);

girl_phase = real(ifft2(girl_phase_f));
girl_magnitude = real(ifft2(girl_magnitude_f));
girl = real(ifft2(girl_phase_f.*girl_magnitude_f));


figure
subplot(1,2,1)
imshow(girl_phase,[])
title("Reconstructed: Only-Phase Spectrum")
subplot(1,2,2)
imshow(uint8(girl_magnitude))
title("Reconstructed: Only-Magnitude Spectrum")



%% part b : reconstruct Berkeley_horses froom its phase-only, magnitude-only

img_horse_f = fft2(img_horse);
horse_phase_f = exp(1i.*angle(img_horse_f));
horse_magnitude_f = abs(img_horse_f);

horse_phase = real(ifft2(horse_phase_f));
horse_magnitude = real(ifft2(horse_magnitude_f));
horse = real(ifft2(horse_phase_f.*horse_magnitude_f));

figure
subplot(2,1,1)
imshow(horse_phase',[])
title("Reconstructed: Only-Phase Spectrum")

subplot(2,1,2)
imshow(uint8(horse_magnitude)',[])
title("Reconstructed: Only-Magnitude Spectrum")


%% part c : Reconstruct Berkeley_girl from Berkeley_horse’s phase spectrum and Berkeley_girl’s magnitude spectrum

girl = real(ifft2(horse_phase_f.*girl_magnitude_f));

figure
imshow(girl,[])
title("Berkeley girl from Berkeley horse’s phase & Berkeley girl’s magnitude spectrum")


%% part d : Reconstruct Berkeley_horse from Berkeley_girl’s phase spectrum and Berkeley_horse’s magnitude spectrum

horse = real(ifft2(girl_phase_f.*horse_magnitude_f));

figure
imshow(horse',[])
title("Berkeley horse from Berkeley girl’s phase & Berkeley horse’s magnitude")


%% part e : Reconstruct Berkeley_girl from ...

img_girl_f = fftshift(fft2(img_girl));
girl_phase_f = exp(1i.*angle(flip(img_girl_f,2)));
girl_magnitude_f = abs(img_girl_f);

girl = real(ifft2(fftshift(girl_phase_f.*girl_magnitude_f)));

figure
imshow(girl,[])
title("The Reconstructed Image in Part E")


