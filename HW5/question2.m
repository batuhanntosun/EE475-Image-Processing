% EE475 : Homework 5
% Batuhan Tosun 2017401141

%% QUESTION 2 : Edge Linking and Completion

%% part a

sigma = 1;

img = imread("Amasya.jpg");
img = double(imgaussfilt(img, sigma));
figure
imshow(uint8(img))
title("Gaussian Filtered Amasya Image")

%%
[M,N] = size(img);

pad_x = padarray(img,[0,1],'symmetric');
pad_y = padarray(img,[1,0],'symmetric');

pad_x = pad_x(:,3:N+2);
pad_y = pad_y(3:M+2,:);

diff_x = pad_x - img;
diff_y = pad_y - img;

% gradient field
mag_grad = (sqrt(diff_x.^2+diff_y.^2)+0.5);
figure
imshow(mag_grad,[])
title("Magnitude of the Gradient Field")
mag_grad = uint8(mag_grad+0.5);

% histogram and threshold finding
[counts, binLocations] = imhist(mag_grad);
total_count = sum(counts);
threshold_count = 0.85*total_count;

figure
imhist(mag_grad);
title("Histogram of Gradient Field")

%% finding 85-percentile for high thresholding
check = 0;
k = 1;
while check < threshold_count
    check = check + counts(k);
    k = k +1;
end

high_threshold = k-1;
low_threshold = high_threshold/2;
display("High threshold: "+high_threshold)
display("Low threshold: "+low_threshold)

%% part b: high threshold
mag_grad_h = (double(mag_grad)>high_threshold)*1;
figure
imshow(mag_grad_h,[])
title("Strong Edges after High Thresholding")

%% part c: low threshold
mag_grad_l = (double(mag_grad)>low_threshold)*1;
figure
imshow(mag_grad_l,[])
title("Only Low Thresholded")
mag_grad_l = mag_grad_l - mag_grad_h;

mag_grad_l_final = zeros(size(mag_grad_l));

for m=1:M
    for n=1:N
        if mag_grad_h(m,n)==1
           mag_grad_l_final(max(m-1,1):min(m+1,M),max(n-1,1):min(n+1,N))=mag_grad_l_final(max(m-1,1):min(m+1,M),max(n-1,1):min(n+1,N))+mag_grad_l(max(m-1,1):min(m+1,M),max(n-1,1):min(n+1,N))*1;
        end
    end
end

mag_grad_l_final = (mag_grad_l_final>0)*1;
mag_grad_final = mag_grad_h + mag_grad_l_final;

figure
imshow(mag_grad_final,[])
title("Final Output")




