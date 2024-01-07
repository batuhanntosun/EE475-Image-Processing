% HOMEWORK 2
% BATUHAN TOSUN 2017401141

%% Question 1 : Nonlinear Monotonic Point Operations

img = imread("lena.bmp");
figure
[counts, binLocations] = imhist(img);
imhist(img);
title("Histogram of the Lena Image")

n_points = 0;
for i=1:length(binLocations)
    if (counts(i)~=0 && n_points==0)
        min_val = binLocations(i);
        n_points = n_points + 1;
    end
    
    if (counts(i)~=0)
        max_val = binLocations(i);
    end
end
        

R = max_val-min_val+1;
display("R value for the Lena image is :"+R);

alpha = 0.8;
f_img = R/2*(1+1/(sin(pi*alpha/2))*sin((double(img)/R-1/2)*pi*alpha));
g_img = R/2*(1+1/(tan(pi*alpha/2))*tan((double(img)/R-1/2)*pi*alpha));

figure
subplot(3,2,1)
imshow(img)
title("Original Image")
subplot(3,2,2)
imhist(img)
title("Histogram of the Original Image");
subplot(3,2,3)
imshow(uint8(f_img))
title("f Transform of the Image")
subplot(3,2,4)
imhist(uint8(f_img))
title("Histogram of the f transform")
subplot(3,2,5)
imshow(uint8(g_img))
title("g transform of the Image")
subplot(3,2,6)
imhist(uint8(g_img))
title("Histogram of the g transform")






