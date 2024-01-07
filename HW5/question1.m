% EE475 : Homework 5
% Batuhan Tosun 2017401141

%%
ia = imread("Circles.jpg");


%% QUESTION 1 : Noisy Edge Detection

% create the circles image

radius = [20,40,60,80];
img = zeros(201,201);
img_edges = zeros(201,201);
img_thick_edges = zeros(201,201);

for i=1:201
    
    for j = 1:201
        
        radius = sqrt((i-101)^2+(j-101)^2);
        if round(radius) <= 20
            img(i,j) = 255;
        elseif round(radius)>20 && round(radius) <=40
            img(i,j) = 192;
        elseif round(radius)>40 && round(radius) <=60
            img(i,j) = 128;
        elseif round(radius)>60 && round(radius) <=80
            img(i,j) = 64;
        end
        
        if round(radius)>=18 && round(radius)<=22
            if round(radius)==20
                img_edges(i,j)=1;
            end
            img_thick_edges(i,j)=1;
        elseif round(radius)>=38 && round(radius)<=42
            if round(radius)==(40)
                img_edges(i,j)=1;
            end
            img_thick_edges(i,j)=1;
        elseif round(radius)>=58 && round(radius)<=62
            if round(radius)==(60)
                img_edges(i,j)=1;
            end
            img_thick_edges(i,j)=1;
        elseif round(radius)>=78 && round(radius)<=82
            if round(radius)==(80)
                img_edges(i,j)=1;
            end
            img_thick_edges(i,j)=1;
        end
        
        
    end
end

figure
subplot(1,2,1)
imshow(uint8(img))
title("Circles Image")
subplot(1,2,2)
imshow(logical(img_edges))
title("Ground Truth Edges")


%%

% part a: Sobel, LoG, Canny
ep_performances = zeros(2,4);
noisy = ["Clean","Noisy"];

n_img = uint8(img);

for k=1:2
    
    sigma = 0.75;
    
    if k==2
        % apply gaussian noise
        n_img = imnoise(uint8(img),'gaussian',0,484/255^2);
        sigma = 3;
    end
    
    % For the Laplacian of Gaussian (LoG)
    gauss = imgaussfilt(uint8(n_img), sigma); % applying gaussian filter

    % Using MATLAB's edge function with parameters 'Sobel' and 'Canny'
    [~,thresholds] = edge(gauss,'Sobel');
    sobel = edge(gauss,'Sobel',thresholds * 0.2);
    [~,thresholdc] = edge(gauss,'Canny',[],sigma);
    canny = edge(n_img,'Canny',[thresholdc],sigma);
    [~,thresholdl] = edge(n_img,'LoG',[],sigma);
    log_matlab = edge(n_img,'LoG',thresholdl*1.5,sigma);
    
    kernel = [1,1,1;1,-8,1;1,1,1];
    [result1] = myConv(double(gauss),kernel);
    threshold = max(result1(:))*0.4;
    % zero crossing testing for the result
    [log] = myZeroTest(result1,9);
    log = logical(log);
    
    ep_performances(k,1) = edgeDetectorPerformance(img_edges,img_thick_edges,sobel);
    ep_performances(k,2) = edgeDetectorPerformance(img_edges,img_thick_edges,canny);
    ep_performances(k,3) = edgeDetectorPerformance(img_edges,img_thick_edges,log);
    ep_performances(k,4) = edgeDetectorPerformance(img_edges,img_thick_edges,log_matlab);

    figure
    subplot(2,2,1)
    imshow(sobel)
    title("Sobel-Edges+"+noisy(k)+" with EP:"+ep_performances(k,1))
    subplot(2,2,2)
    imshow(canny)
    title("Canny-Edges+"+noisy(k)+" with EP:"+ep_performances(k,2))
    subplot(2,2,3)
    imshow(log)
    title("LoG-Edges+"+noisy(k)+" with EP:"+ep_performances(k,3))
    subplot(2,2,4)
    imshow(log_matlab)
    title("Matlab LoG-Edges+"+noisy(k)+" with EP:"+ep_performances(k,4))

end

ep_performances


%% part a again but with


%% FUNCTIONS
function [res] = myConv(img,kernel)
[M,N] = size(img);
kernel_size = size(kernel,1);
pad_size = floor((kernel_size-1)/2);
pad_img = padarray(img,[pad_size,pad_size],'symmetric');
res = zeros(M,N);

for m = 1:M
    for n=1:N
        temp=kernel.*pad_img(m:m+kernel_size-1,n:n+kernel_size-1);
        res(m,n) = sum(temp(:));
    end
end
end

function [res] = myZeroTest(img,threshold)
[M,N] = size(img);
res = zeros(M,N);

for m = 2:M-1
    
    for n=2:N-1
        
        a11 = img(m-1,n-1);
        a12 = img(m-1,n);
        a13 = img(m-1,n+1);
        a21 = img(m,n-1);
        a23 = img(m,n+1);
        a31 = img(m+1,n-1);
        a32 = img(m+1,n);
        a33 = img(m+1,n+1);
        
        %cond = (a12*a32<0)*1+(a21*a23<0)*1+(a11*a33<0)*1+(a31*a13<0)*1;
        
        th1 = abs(a12-a32);
        th2 = abs(a21-a23);
        th3 = abs(a11-a33);
        th4 = abs(a31-a13);
        
%         cond = 1*(th1> threshold && (a12*a32<0)) + 1*(th2> threshold && (a21*a23<0)) +1*(th3> threshold && (a11*a33<0)) + 1*(th4> threshold && (a31*a13<0));
%         
%         if cond >= 2
%             res(m,n) = 1;
%         end
        if th1> threshold && (a12*a32<0)
            res(m,n) = 1;
        elseif th2> threshold && (a21*a23<0)
            res(m,n) = 1;
        elseif th3> threshold && (a11*a33<0)
            res(m,n) = 1;
        elseif th4> threshold && (a31*a13<0)
            res(m,n) = 1;
        end
        
        
    end
end

end

function [ep] = edgeDetectorPerformance(grt,grt_thick,exper)
    [M,N] = size(grt);
    [rows,cols] = find(grt);
    N_grt = length(rows);
    ep = 0;
    for i=1:N_grt
        row = rows(i);
        col = cols(i);
        if grt(row,col)*exper(row,col) == 1
            ep = ep + 1;
        else
            reg = exper(max(1,row-2):min(row+2,M),max(1,col-2):min(col+2,N));
            sum_reg = sum(reg(:));
            if sum_reg~=0
                ep = ep + 0.5;
            end
        end
        
    end

    ep = ep/N_grt;
end
