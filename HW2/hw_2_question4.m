% HOMEWORK 2
% BATUHAN TOSUN 2017401141

%% Question 4: Image Resizing

img = imread("CAMERA.JPG");
pix_coords = [1:256];
old_range = 399;
new_range = 255;

% rescaling the values in [1:400] to [1:256] 
npix_coords = [1:400];
npix_coords = (npix_coords-1)*new_range/old_range+1;

n_img = zeros(400,400);

% for filling the each pixel of new image
for i = 1:400 % for each row
    for j = 1:400 % for each column
        
        
        low_x = floor(npix_coords(i));
        low_y = floor(npix_coords(j));
        
        % checking for the pixels in the edges
        if low_x ~= 256
            high_x = low_x+1;
        else
            high_x = low_x;
        end
        if low_y ~= 256
            high_y = low_y+1;
        else
            high_y = low_y;
        end        
        
        % distance to lower bounds of the coordinate are found
        dx = npix_coords(i) - low_x;
        dy = npix_coords(j) - low_y;
        
        % using the bilinear interpolation formula we calculate and assign
        % the corresponding pixel values
        n_img(i,j) = (1-dx)*(1-dy)*img(low_x,low_y)+(dx)*(dy)*img(high_x,high_y) + (1-dx)*(dy)*img(low_x,high_y)+(dx)*(1-dy)*img(high_x,low_y);
    
    end
end

n_img = uint8(n_img + 0.5);
figure
subplot(2,1,1)
imshow(img)
subplot(2,1,2)
imshow(n_img)

% save the resized image
imwrite(n_img, "RESIZED_CAMERA.JPG");
        