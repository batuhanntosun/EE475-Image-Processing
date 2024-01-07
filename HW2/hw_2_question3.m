% HOMEWORK 2
% BATUHAN TOSUN 2017401141

%% Question 3: Histogram Equalization

%% a) my own program for computing the histogram

directory = "Fractured spine.jpg";
img = imread(directory);

[counts, binLocations] = myHistogram(img, false);
 
%% b) my own program for histogram equalization
[new_img, cum_sum_counts] = myHistEq(img, counts);

figure
subplot(2,2,1)
imshow(img);title("Original Image");
subplot(2,2,2)
[~, ~] = myHistogram(img, true);
subplot(2,2,3)
imshow(new_img);title("Resulting Image");
subplot(2,2,4)
[~, ~] = myHistogram(new_img, true);

figure
subplot(1,2,1)
imshow(img);title("Original Image");
subplot(1,2,2)
imshow(new_img);title("Resulting Image");


figure
subplot(2,1,1)
[~, ~] = myHistogram(img, true);
subplot(2,1,2)
[~, ~] = myHistogram(new_img, true);

figure
plot([0:255],cum_sum_counts)
title("Histogram-equalization Transformation Function")

%% with matlab functions

J = histeq(img);
J2 = adapthisteq(img);
figure
subplot(3,2,1)
imshow(new_img);title("Resulting Image with myHistEq.m");
subplot(3,2,2)
[~, ~] = myHistogram(new_img, true);
subplot(3,2,3)
imshow(J);title("Resulting Image with histeq.m");
subplot(3,2,4)
[~, ~] = myHistogram(J, true);
subplot(3,2,5)
imshow(J2);title("Resulting Image with adapthisteq.m");
subplot(3,2,6)
[~, ~] = myHistogram(J2, true);

figure
subplot(1,3,1)
imshow(new_img);title("Resulting Image with myHistEq.m");
subplot(1,3,2)
imshow(J);title("Resulting Image using histeq.m");
subplot(1,3,3)
imshow(J2);title("Resulting Image using adapthisteq.m");

figure
subplot(3,1,1)
[~, ~] = myHistogram(new_img, true);
subplot(3,1,2)
[~, ~] = myHistogram(J, true);
subplot(3,1,3)
[~, ~] = myHistogram(J2, true);


%% the same processes for the Baby image

directory = "Baby.png";
img = imread(directory);

img = uint8(mean(double(img),3));

[counts, binLocations] = myHistogram(img, false);
 
[new_img, cum_sum_counts] = myHistEq(img, counts);

figure
subplot(2,2,1)
imshow(img);title("Original Image");
subplot(2,2,2)
[~, ~] = myHistogram(img, true);
subplot(2,2,3)
imshow(new_img);title("Resulting Image");
subplot(2,2,4)
[~, ~] = myHistogram(new_img, true);


figure
subplot(1,2,1)
imshow(img);title("Original Image");
subplot(1,2,2)
imshow(new_img);title("Resulting Image");

figure
subplot(2,1,1)
[~, ~] = myHistogram(img, true);
subplot(2,1,2)
[~, ~] = myHistogram(new_img, true);

figure
plot([0:255],cum_sum_counts)
title("Histogram-equalization Transformation Function")

%% with matlab functions


J = histeq(img);
J2 = adapthisteq(img);
figure
subplot(3,2,1)
imshow(new_img);title("Resulting Image with myHistEq.m");
subplot(3,2,2)
[~, ~] = myHistogram(new_img, true);
subplot(3,2,3)
imshow(J);title("Resulting Image with histeq.m");
subplot(3,2,4)
[~, ~] = myHistogram(J, true);
subplot(3,2,5)
imshow(J2);title("Resulting Image with adapthisteq.m");
subplot(3,2,6)
[~, ~] = myHistogram(J2, true);

figure
subplot(1,3,1)
imshow(new_img);title("Resulting Image with myHistEq.m");
subplot(1,3,2)
imshow(J);title("Resulting Image using histeq.m");
subplot(1,3,3)
imshow(J2);title("Resulting Image using adapthisteq.m");

figure
subplot(3,1,1)
[~, ~] = myHistogram(new_img, true);
subplot(3,1,2)
[~, ~] = myHistogram(J, true);
subplot(3,1,3)
[~, ~] = myHistogram(J2, true);


% FUNCTIONS: for computing histogram and implementing histogram
% equalization

function [counts,binLocations] = myHistogram(img, display)

    binLocations = [0:255];
    counts = zeros(1,256); % holds the number of occurrence of each gray level value

    for i = 0:255 % since gray level is in between 0-255
        counts(i+1)=sum(sum(img==i)); % finding the the number of occurrence of gray level i
    end

    if display % bar plot for displaying the histogram
        bar(binLocations, counts,'b');
        title("Histogram of the Image")
        xlabel("Gray Levels");
        ylabel("Number of Occurence");
    end

end

function [new_img, cum_sum_counts] = myHistEq(img, counts)

    [M, N] = size(img);
    total_pixels = M*N; % for normalization
    normalized_counts = counts/total_pixels; % the number of occurence of each gray level is normalized
    cum_sum_counts = cumsum(normalized_counts); % CMF is obtained using cumsum

    % image mapping

    new_img = zeros(M,N);

    for i=0:255
        new_img = new_img + cum_sum_counts(i+1)*(img==i); % generating a new image by passing it through the cmf (mapping)
    end

    new_img = uint8(255*new_img+0.5);

end



    