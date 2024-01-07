% Homework 1
% Batuhan Tosun 2017401141

%% Question 1

% reading the bmp file
[img]  = imread("Fish.bmp");
figure;
imshow(img);
title("Fish.bmp");

% writing the png file
imwrite(img,"Fish.png");

% info about the file
info = imfinfo("Fish.png");

%% a) components
R_img = img(1:end,1:end,1);
G_img = img(1:end,1:end,2);
B_img = img(1:end,1:end,3);
figure
imshow(R_img)
title("R color components of the Fish")
figure
imshow(G_img)
title("G color components of the Fish")
figure
imshow(B_img)
title("B color components of the Fish")

%% b) creating new image Gray_Fish

gray_img = uint8((double(R_img)+double(G_img)+double(B_img))/3);
figure
imshow(gray_img)
title("Gray"+"Fish.bmp")
imwrite(gray_img,"Gray_Fish.bmp");

%% c1) plotting histograms using imhist
figure
[countsR, binLocationsR] = imhist(R_img);
bar(binLocationsR,countsR,"r");

hold on;
[countsB, binLocationsB] = imhist(B_img);
bar(binLocationsB,countsB,"b");

hold on;
[countsG, binLocationsG] = imhist(G_img);
bar(binLocationsG,countsG,"g");
title("Joint Histogram Distribution of R,G,B components")
legend("R","B","G");
xlim([-1,256])
xlabel("gray levels")
ylabel("frequency of occurrence")

%% c2) plot seperately
figure
imhist(R_img);
title("Histogram of R color components")
figure
imhist(G_img);
title("Histogram of G color components")
figure
imhist(B_img);
title("Histogram of B color components")
figure
imhist(gray_img);
title("Histogram of Gray-level components")

%% finding the spatial locations of the pixels
% ) d

figure
subplot(2,2,1)
imshow(img)
title("Original Image")
binary_img = uint8((R_img>150).*(G_img>130).*(B_img<10));
subplot(2,2,2)
imshow(binary_img*255)
title("Binary Image: R>150 & G>130 & B<10")
% f)
binary_img2 = uint8((R_img<100).*(G_img>130).*(B_img>130));
subplot(2,2,3)
imshow(binary_img2*255)
title("Binary Image: R<100 & G>130 & B>130")
% f)
binary_img3 = uint8((R_img>130).*(G_img<100).*(B_img>130));
subplot(2,2,4)
imshow(binary_img3*255)
title("Binary Image: R>130 & G<100 & B>130")

figure
imshow(binary_img*255)
title("Binary Image: R>150 & G>130 & B<130")
figure
imshow(binary_img2*255)
title("Binary Image: R<100 & G>130 & B>130")
figure
imshow(binary_img3*255)
title("Binary Image: R>130 & G<100 & B>130")

% masking operation
figure
imshow(img.*binary_img)
title("R>150 & G>130 & B<10")
figure
imshow(img.*binary_img2)
title("R<100 & G>130 & B>130")
figure
imshow(img.*binary_img3)
title("R>130 & G<100 & B>130")

%% finding the maximum R component
threshold=46
r_max = (R_img == 255);
bin_map_reddest = r_max.*(B_img <threshold).*(G_img<threshold);
s = sum(sum(bin_map_reddest));
[row, col] = find(bin_map_reddest);

for i=1:4
    a = img(row(i),col(i),:);
    a1 = a(1,1,1);
    a2 = a(1,1,2);
    a3 = a(1,1,3);
    display([row(i),col(i)])
    display([a1,a2,a3]);
end
   