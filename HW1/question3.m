% Homework 1
% Batuhan Tosun 2017401141

%% question 3 : Pixel Varieties

% a: emission object

figure
galaxy_img = imread("Cetus_NGC1052Galaxy.jpg");
subplot(2,1,1)
imshow(galaxy_img)
emission_points = (galaxy_img(:,:,1)==255).*(galaxy_img(:,:,2)==255).*(galaxy_img(:,:,3)==255);
subplot(2,1,2)
imshow(emission_points)

% using emission_points we can get the coordinates of the points that emits
% the most amount of light

num_light = sum(sum(emission_points));
[row, col] = find(emission_points); % rows and columns of the points are found
for i=1:5
    display([row(i), col(i)])
end

%% b : range camera 

room_img1 = imread("Room.png");
room_img1 = uint8((double(room_img1(:,:,1))+double(room_img1(:,:,2))+double(room_img1(:,:,3)))/3);
figure
imshow(room_img1)
title("Room.png")

closest_points = (room_img1<6);
farthest_points = (room_img1>243);

[r1,c1] = find(closest_points);
[r2,c2] = find(farthest_points);


s1 = sum(sum(closest_points));
s2 = sum(sum(farthest_points));

%% c : material density

material_img1 = imread("SKULL_head24.tif");
figure
subplot(1,3,1)
imshow(material_img1)
title("SKULLhead24.tif")
subplot(1,3,2)
imshow(double(material_img1).*(material_img1>60))
title("Opaque Regions")
subplot(1,3,3)
imshow(double(material_img1).*(material_img1<40).*(material_img1>10))
title("Transparent Regions")


%% d : thermal
threshold = 200;
thermal_img = imread("Thermal_pedestrian_00014.bmp");

[hot_rows, hot_colums] = find(thermal_img==255);
[cold_rows, cold_colums] = find(thermal_img==0);
n_hot = sum(sum(thermal_img==255));
n_cold = sum(sum(thermal_img==0));

display("Number of pixels with value of 255: "+n_hot)
display("Number of pixels with value of 0: "+n_cold)

for i=1:5
    display([hot_rows(i), hot_colums(i)])
end

for i=1:5
    display([cold_rows(i), cold_rows(i)])
end

thermal_map = uint8((thermal_img>threshold)*255);
figure
subplot(1,2,1)
imshow(thermal_img);
title("original image")
subplot(1,2,2)
imshow(thermal_map);
title("Thermal threshold image")


%% e : taxi

taxi1 = imread("taxi36.pgm");
taxi2 = imread("taxi38.pgm");
taxi3 = imread("taxi40.pgm");

figure
subplot(1,3,1)
imshow(taxi1)
title("Taxi1: taxi36.pgm")
subplot(1,3,2)
imshow(taxi2)
title("Taxi2: taxi38.pgm")
subplot(1,3,3)
imshow(taxi3)
title("Taxi3: taxi40.pgm")

diff21 = 255 - abs(taxi2 - taxi1);
diff32 = 255 - abs(taxi3 - taxi2);
diff31 = 255 - abs(taxi3 - taxi1);

figure
subplot(3,1,1)
imshow(diff21)
title("255-|Taxi2-Taxi1|")
subplot(3,1,2)
imshow(diff32)
title("255-|Taxi3-Taxi2|")
subplot(3,1,3)
imshow(diff31)
title("255-|Taxi3-Taxi1|")





