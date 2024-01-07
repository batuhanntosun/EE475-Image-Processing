% EE475 : Homework 5
% Batuhan Tosun 2017401141

%% QUESTION 4 : Segmentation by Clustering

img = double(imread("Tiger_crop.jpg"));
figure
image(uint8(img))
title("Tiger Image")

%% part a: using feature vector 1
[M,N,K] = size(img);
initial_positions = [16,258;69,256;157,256;354,256];
seg_img = zeros(M,N);
color_seg_img =  zeros(M,N,K);
[seg_img, color_seg_img] = kMeansClustering(img/255, initial_positions);
figure
imshow(uint8(color_seg_img))
title("Segmentation via Feature Vector f_1")


%% part b: using feature vector 2
pad_img = padarray(img,[1,1],'symmetric');
new_img = zeros(M,N,8);

for m = 1:M
    for n=1:N
        new_img(m,n,:) = featureVecExtractor2(pad_img, m, n);
    end
end

initial_positions = [16,258;69,256;157,256;354,256];
seg_img2 = zeros(M,N);
color_seg_img2 =  zeros(M,N,K);
[seg_img2, color_seg_img2] = kMeansClustering(new_img, initial_positions);
figure
imshow(uint8(color_seg_img2))
title("Segmentation via Feature Vector f_2")

%% part c: SUPERPIXELS

N = 3000; % number of superpixels
[L,NumLabels] = superpixels(uint8(img),N);
figure
BW = boundarymask(L);
imshow(imoverlay(uint8(img),BW,'cyan'),'InitialMagnification',100)
title("Boundaries of 3000 Superpixels")

outputImage = zeros(size(img),'like',img);
idx = label2idx(L);
numRows = size(img,1);
numCols = size(img,2);

for labelVal = 1:NumLabels
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    outputImage(redIdx) = mean(img(redIdx));
    outputImage(greenIdx) = mean(img(greenIdx));
    outputImage(blueIdx) = mean(img(blueIdx));
end    

figure
image(uint8(outputImage))
title("Resulting Image after SLIC")
%% using feature vector 3
[M,N,~] = size(outputImage);
new_img = zeros(M,N,5);

for m = 1:M
    for n=1:N
        new_img(m,n,:) = featureVecExtractor3(outputImage, m, n);
    end
end

% 4 seed points is determined
initial_positions = [25,282;70,270;150,246;350,255];

seg_img3 = zeros(M,N);
color_seg_img3 =  zeros(M,N,K);
[seg_img3, color_seg_img3] = kMeansClustering(new_img, initial_positions);
figure
imshow(uint8(color_seg_img3))
title("Segmentation via Feature Vector f_3 (Superpixels)")


%%

function [seg_img, color_seg_img] = kMeansClustering(new_img, initial_positions)

[M,N,K] = size(new_img); 
% 4 seed points is determined
%initial_positions = [24,406;162,464;156,249;272,358];

c1 = new_img(initial_positions(1,1),initial_positions(1,2),:); % blue
c2 = new_img(initial_positions(2,1),initial_positions(2,2),:); % green
c3 = new_img(initial_positions(3,1),initial_positions(3,2),:); % orange
c4 = new_img(initial_positions(4,1),initial_positions(4,2),:); % beige

tot_segments = [1,1,1,1];

seg_img = zeros(M,N);
seg_img(initial_positions(1,1),initial_positions(1,2))=1;
seg_img(initial_positions(2,1),initial_positions(2,2))=2;
seg_img(initial_positions(3,1),initial_positions(3,2))=3;
seg_img(initial_positions(4,1),initial_positions(4,2))=4;

blue_color= [0,0,255];
blue_color = reshape(blue_color,[1,1,3]);

orange_color = [180,120,0];
orange_color = reshape(orange_color,[1,1,3]);

green_color = [0,150,0];
green_color = reshape(green_color,[1,1,3]);

beige_color = [255,255,240];
beige_color = reshape(beige_color,[1,1,3]);

field = 'col';
value = {blue_color;
         green_color;
         orange_color;
         beige_color};
     
color_struct = struct(field,value);

color_seg_img = zeros(M,N,3);

% initial threshold
threshold = 10;


while threshold > 2
    
    for m=1:M

        for n=1:N

            pixel = new_img(m,n,:);
            
            % distances
            dist1 = vecDist(pixel,c1);
            dist2 = vecDist(pixel,c2);
            dist3 = vecDist(pixel,c3);
            dist4 = vecDist(pixel,c4);

            all_dist = [dist1,dist2,dist3,dist4];
            [~,ind] = min(all_dist);
            seg_img(m,n)=ind(1);
            color_seg_img(m,n,:) = color_struct(ind(1)).col;

        end

    end

    mask1 = (seg_img==1)*1;
    mask2 = (seg_img==2)*1;
    mask3 = (seg_img==3)*1;
    mask4 = (seg_img==4)*1;

    tot_segments(1) = sum(mask1(:));
    tot_segments(2) = sum(mask2(:));
    tot_segments(3) = sum(mask3(:));
    tot_segments(4) = sum(mask4(:));

    % new centroid means
    n_c1 = sum(sum(mask1.*new_img,1),2)/(tot_segments(1)+1e-6);
    n_c2 = sum(sum(mask2.*new_img,1),2)/(tot_segments(2)+1e-6);
    n_c3 = sum(sum(mask3.*new_img,1),2)/(tot_segments(3)+1e-6);
    n_c4 = sum(sum(mask4.*new_img,1),2)/(tot_segments(4)+1e-6);

    threshold = vecDist(c1,n_c1) + vecDist(c2,n_c2) + vecDist(c3,n_c3) + vecDist(c4,n_c4);

    c1 = n_c1;
    c2 = n_c2;
    c3 = n_c3;
    c4 = n_c4;
    display(threshold)
    
end

end

function [featureVec]=featureVecExtractor1(pad_img, x, y)
    
    featureVec = zeros(1,1,3);
    x = x + 1;
    y = y + 1;
    featureVec(1,1,1) = pad_img(x,y,1);
    featureVec(1,1,2) = pad_img(x,y,2);
    featureVec(1,1,3) = pad_img(x,y,3);

end


function [featureVec]=featureVecExtractor2(pad_img, x, y)
    
    featureVec = zeros(1,1,8);
    x = x + 1;
    y = y + 1;
    [M,N,~] = size(pad_img);
    featureVec(1,1,1) = pad_img(x,y,1)/255;
    featureVec(1,1,2) = pad_img(x,y,2)/255;
    featureVec(1,1,3) = pad_img(x,y,3)/255;
    featureVec(1,1,4) = (x-1)/(M-2);
    featureVec(1,1,5) = (y-1)/(N-2);
    
    red_neighbor = pad_img(x-1:x+1,y-1:y+1,1);
  
    red_neighbor = red_neighbor(:)/255;
    
    green_neighbor = pad_img(x-1:x+1,y-1:y+1,2);
    green_neighbor = green_neighbor(:)/255;
    
    blue_neighbor = pad_img(x-1:x+1,y-1:y+1,3);
    blue_neighbor = blue_neighbor(:)/255;
    
    var_red = var(red_neighbor);
    var_green = var(green_neighbor);
    var_blue = var(blue_neighbor);
    
    featureVec(1,1,6) = var_red;
    featureVec(1,1,7) = var_green;
    featureVec(1,1,8) = var_blue;
    
end

function [featureVec]=featureVecExtractor3(pad_img, x, y)

    [M,N,~] = size(pad_img);
    featureVec = zeros(1,1,5);

    featureVec(1,1,1) = pad_img(x,y,1)/255;
    featureVec(1,1,2) = pad_img(x,y,2)/255;
    featureVec(1,1,3) = pad_img(x,y,3)/255;
    featureVec(1,1,4) = x/M;
    featureVec(1,1,5) = y/N;
        
end


function [dist] = vecDist(pixel,cluster)

    K = size(pixel,3);
    diff = pixel-cluster;
    dist = 0;
    for k=1:K
        dist = dist + diff(:,:,k)^2;
    end
    
    dist = sqrt(dist);
    
end