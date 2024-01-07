% Homework 1
% Batuhan Tosun 2017401141

%% Question 2

%a: find average optical density

img1 = imread("rsz_05_00_gray.png");
[M1,N1] = size(img1);
img2 = imread("rsz_05_05_gray.png");
[M2,N2] = size(img2);
img3 = imread("rsz_05_11_gray.png");
[M3,N3] = size(img3);
img4 = imread("Baby.png"); % it has RGB channels
img4 = uint8(mean(double(img4),3));
[M4,N4] = size(img4);

aod1 = sum(sum(double(img1)))/(M1*N1);
aod2 = sum(sum(double(img2)))/(M2*N2);
aod3 = sum(sum(double(img3)))/(M3*N3);
aod4 = sum(sum(double(img4)))/(M4*N4);
display("rsz_05_00_gray.png, AOD => "+aod1)
display("rsz_05_05_gray.png, AOD => "+aod2)
display("rsz_05_11_gray.png, AOD => "+aod3)
display("Baby.png, AOD => "+aod4)


%% b: plotting the histogram of face images

figure
subplot(2,2,1)
imhist(img1)
title("rsz0500gray.png")
ylabel("frequnecy of occurrence")
xlabel("gray levels")
subplot(2,2,2)
imhist(img2)
title("rsz0505gray.png")
ylabel("frequnecy of occurrence")
xlabel("gray levels")
subplot(2,2,3)
imhist(img3)
title("rsz0511gray.png")
ylabel("frequnecy of occurrence")
xlabel("gray levels")
subplot(2,2,4)
imhist(img4)
title("Baby.png")
ylabel("frequnecy of occurrence")
xlabel("gray levels")

%% c: set AOD value to 100 


c1 = (100-aod1);
n_img1 = double(img1) + c1;
n_img1 = (n_img1<=255).*n_img1 + ((n_img1>255)*(255)); % setting the pixel values to 255 which are above 255
n_img1 = (n_img1>=0).*n_img1; % setting the pixel values to 0 which are below 0
n_img1 = uint8(n_img1);

c2 = (100-aod2);
n_img2 = double(img2) + c2;
n_img2 = (n_img2<=255).*n_img2 + ((n_img2>255)*255); % setting the pixel values to 255 which are above 255
n_img2 = (n_img2>=0).*n_img2; % setting the pixel values to 0 which are below 0
n_img2 = uint8(n_img2);

c3 = (100-aod3);
n_img3 = double(img3) + c3;
n_img3 = (n_img3<=255).*n_img3 + ((n_img3>255)*255); % setting the pixel values to 255 which are above 255
n_img3 = (n_img3>=0).*n_img3; % setting the pixel values to 0 which are below 0
n_img3 = uint8(n_img3);

c4 = (100-aod4);
n_img4 = double(img4) + c4;
n_img4 = (n_img4<=255).*n_img4 + ((n_img4>255)*255); % setting the pixel values to 255 which are above 255
n_img4 = (n_img4>=0).*n_img4; % setting the pixel values to 0 which are below 0
n_img4 = uint8(n_img4);

aod1_after = sum(sum(double(n_img1)))/(M1*N1);
aod2_after = sum(sum(double(n_img2)))/(M2*N2);
aod3_after = sum(sum(double(n_img3)))/(M3*N3);
aod4_after = sum(sum(double(n_img4)))/(M4*N4);

figure
subplot(2,4,1)
imshow(img1)
title("AOD:"+aod1+" rsz0500gray.png")
subplot(2,4,2)
imshow(img2)
title("AOD:"+aod2+" rsz0505gray.png")
subplot(2,4,3)
imshow(img3)
title("AOD:"+aod3+" rsz0511gray.png")
subplot(2,4,4)
imshow(img4)
title("AOD:"+aod4+" Baby.png")

subplot(2,4,5)
imshow(n_img1)
title("AOD:100 rsz0500gray.png")
subplot(2,4,6)
imshow(n_img2)
title("AOD:100 rsz0505gray.png")
subplot(2,4,7)
imshow(n_img3)
title("AOD:100 rsz0511gray.png")
subplot(2,4,8)
imshow(n_img4)
title("AOD:100 Baby.png")

figure
subplot(4,2,1)
imhist(img1)
title("Histogram prev: rsz0500gray.png")
subplot(4,2,2)
imhist(n_img1)
title("Histogram after: rsz0500gray.png")
subplot(4,2,3)
imhist(img2)
title("Histogram prev: rsz0505gray.png")
subplot(4,2,4)
imhist(n_img2)
title("Histogram after: rsz0505gray.png")
subplot(4,2,5)
imhist(img3)
title("Histogram prev: rsz0511gray.png")
subplot(4,2,6)
imhist(n_img3)
title("Histogram after: rsz0511gray.png")
subplot(4,2,7)
imhist(img4)
title("Histogram prev: Baby.png")
subplot(4,2,8)
imhist(n_img4)
title("Histogram after: Baby.png")


%% d: change the luminance range

a = [0.5 2];

figure
subplot(3,4,1)
imshow(img1)
title("Org: rsz0500gray.png")
subplot(3,4,2)
imshow(img2)
title("Org: rsz0505gray.png")
subplot(3,4,3)
imshow(img3)
title("Org: rsz0511gray.png")
subplot(3,4,4)
imshow(img4)
title("Org: Baby.png")



for i=1:2
    
    n_img1 = double(img1)*a(i);
    n_img2 = double(img2)*a(i); 
    n_img3 = double(img3)*a(i); 
    n_img4 = double(img4)*a(i);

    aod_afteri_1 = sum(sum(n_img1))/(M1*N1);
    aod_afteri_2 = sum(sum(n_img2))/(M2*N2);
    aod_afteri_3 = sum(sum(n_img3))/(M3*N3);
    aod_afteri_4 = sum(sum(n_img4))/(M4*N4);
    
    n_img1 = n_img1 + (aod1 - aod_afteri_1);
    n_img2 = n_img2 + (aod2 - aod_afteri_2);
    n_img3 = n_img3 + (aod3 - aod_afteri_3);
    n_img4 = n_img4 + (aod4 - aod_afteri_4);
    
    n_img1 = uint8(n_img1+0.5);
    n_img2 = uint8(n_img2+0.5);
    n_img3 = uint8(n_img3+0.5);
    n_img4 = uint8(n_img4+0.5);
    
    subplot(3,4,1+4*i)
    imshow(n_img1)
    title("a="+a(i)+": rsz0500gray.png")
    subplot(3,4,2+4*i)
    imshow(n_img2)    
    title("a="+a(i)+": rsz0505gray.png")
    subplot(3,4,3+4*i)
    imshow(n_img3)
    title("a="+a(i)+": rsz0511gray.png")    
    subplot(3,4,4+4*i)
    imshow(n_img4)
    title("a="+a(i)+": Baby.png")

    
end



    




