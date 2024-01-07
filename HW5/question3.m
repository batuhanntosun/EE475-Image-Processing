% EE475 : Homework 5
% Batuhan Tosun 2017401141

%% QUESTION 3 : Segmentation by Region Growing
load('Berkeley_Deer.mat')
ground1=groundTruth{1,3}.Boundaries;
ground_truth = groundTruth{1,3}.Segmentation;
display(unique(ground_truth))

figure,
imagesc(ground1)
title("Segment Borders")

img = double(imread("Berkeley_deer.jpg"));
figure
image(uint8(img))
title("Berkeley deer Image")
[M,N,~] = size(img); 

%%
ground_truth = double(ground_truth);
ground_truth(ground_truth==3)=1;
ground_truth(ground_truth==4)=3;
ground_truth(ground_truth==2)=4;
ground_truth(ground_truth==3)=2;
ground_truth(ground_truth==4)=3;
display(unique(ground_truth))

%% visualize ground  truth
brown_color = [70,40,0];
brown_color = reshape(brown_color,[1,1,3]);

green_color = [0,100,0];
green_color = reshape(green_color,[1,1,3]);

yellow_color = [250,250,0];
yellow_color = reshape(yellow_color,[1,1,3]);

white_brown_color = [210,120,0];
white_brown_color = reshape(white_brown_color,[1,1,3]);

field = 'col';
value = {green_color;
         yellow_color;
         brown_color;
         white_brown_color};
     
color_struct = struct(field,value);
%%
real_seg_img = zeros(size(img));

for m=1:M
    for n=1:N
        real_seg_img(m,n,:) = color_struct((ground_truth(m,n))).col;
    end
end
figure
imshow(uint8(real_seg_img));
title("Original Segmented Image")

%% another way
% initialization step
% 3 seeds: 2 for background and 1 for deer
% initial positions

initial_positions = [35,51;250,100;160,160];
threshold = 10;

c1 = img(103,473,:);
c2 = img(250,100,:);
c3 = img(174,224,:);
c4 = img(166,201,:);

tot_segments = [1,1,1,1];
prev_tot_segments = [0,0,0,0];

seg_img = zeros(M,N);
seg_img(103,473)=1;
seg_img(250,100)=2;
seg_img(174,224)=4;
seg_img(166,201)=3; 

not_look_again = zeros(M,N)+1;

color_seg_img = zeros(size(img));

tot_unlabeled = sum(sum(1*(seg_img==0)));

[rows, cols] = find(seg_img.*not_look_again);
iter=length(rows);
figure

prev_iter = 0;
iter_change = iter;
figure
while tot_unlabeled ~=0
    
    drawnow;
    for ii=1:iter
       color = zeros(1,1,3);
       row = rows(ii);
       col = cols(ii);
       label = seg_img(row,col);
       
       if label == 1
           center = c1;
       elseif label == 2
           center = c2;
       elseif label == 3
           center = c3;
       else
           center = c4;
       end
       total_ones = 0;
       % 8-connected part
       for i=max(1,row-1):min(M,row+1)
           for j = max(1,col-1):min(N,col+1)
              
              if seg_img(i,j)~=0
                  total_ones = total_ones + 1;
              else
                  pixel = img(i,j,:);
                  diff = pixel-center;
                  th = sqrt(diff(:,:,1)^2+diff(:,:,2)^2+diff(:,:,3)^2);
                  if(th<threshold)
                      seg_img(i,j) = label;
                      color_seg_img(i,j,:) = color_struct(label).col;
                  end
              end
              
           end
       end
       
       if total_ones == 9
           not_look_again(row,col) = 0;
       end
       
    end
    
    prev_tot_segments = tot_segments;
    
    mask1 = (seg_img==1)*1;
    mask2 = (seg_img==2)*1;
    mask3 = (seg_img==3)*1;
    mask4 = (seg_img==4)*1;

    
    tot_segments(1) = sum(mask1(:));
    tot_segments(2) = sum(mask2(:));
    tot_segments(3) = sum(mask3(:));
    tot_segments(4) = sum(mask4(:));
    
    c1 = sum(sum(mask1.*img,1),2)/(tot_segments(1)+1e-6);
    c2 = sum(sum(mask2.*img,1),2)/(tot_segments(2)+1e-6);
    c3 = sum(sum(mask3.*img,1),2)/(tot_segments(3)+1e-6);
    c4 = sum(sum(mask4.*img,1),2)/(tot_segments(4)+1e-6);

    tot_unlabeled = sum(sum(1*(seg_img==0)));
    
    [rows, cols] = find(seg_img.*not_look_again);
    iter=length(rows);
    
    iter_change = sum(tot_segments(:))-sum(prev_tot_segments(:));
    if iter_change == 0 
        threshold = threshold + 10;
        display("a change !!")
    end
    imshow(uint8(color_seg_img))
    display(tot_unlabeled)
    prev_iter = iter;

end
%%
seg_img(seg_img==4)=3;

%% result
figure
imshow(uint8(color_seg_img))
%gs = goodSegmentation(double(ground_truth),seg_img)
title("Resulting Segmented Image with 4 Labels")
%% result 2


for m=1:M
    for n=1:N
        color_seg_img(m,n,:) = color_struct((seg_img(m,n))).col;
    end
end
figure
imshow(uint8(color_seg_img));
gs = goodSegmentation(double(ground_truth),seg_img)
title("Resulting Segmented Image with SP: "+gs)

%%
figure
subplot(1,2,1)
imshow(uint8(real_seg_img));
title("Ground Truth-Segmented Image")
subplot(1,2,2)
imshow(uint8(color_seg_img));
title("Seed Growing Segmented Image")
%% functions
function [gs] = goodSegmentation(grt,expt)
    all_g = zeros(1,3);
    gs = 0;
    for i=1:3
        temp1 = (grt==i)*1;
        temp2 = (expt==i)*1;
        int = temp1.*temp2;
        uni = temp1+temp2;
        uni(uni==2)=1;
        current = sum(int(:))/sum(uni(:));
        all_g(1,i) = current;
        gs = gs + current;
    end
    all_g
end
