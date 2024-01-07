% EE475 HW4
% Batuhan Tosun 2017401141
%% Question 3: Laplacian in Frequency Domain

M = 256;
f_s = 2*pi/M;
u = 0:f_s:2*pi-f_s;
u = u-pi;
v = u;
[V, U] = meshgrid(v,u);

%%
L_uv = (V.^2+U.^2);
figure
surf(U,V,L_uv);
axis tight
title("L(u,v)")

Q_uv = -(exp(1i*(V))+exp(-1i*(V))+exp(1i*(U))+exp(-1i*(U))-4);
figure
surf(U,V,Q_uv);
axis tight
title("Q(u,v)")

K_uv = -(exp(1i*(V))+exp(-1i*(V))+exp(1i*(U))+exp(-1i*(U))+exp(1i*(V)+1i*(U))+exp(-1i*(V)-1i*(U))+exp(1i*(U)-1i*(V))+exp(-1i*(U)+1i*(V))-8);
figure
surf(U,V,K_uv);
axis tight
title("K(u,v)")


%%

diff1 = abs(L_uv/10-K_uv/12);
diff2 = abs(L_uv/10-Q_uv/4);
figure
subplot(1,2,1)
surf(U,V,diff1);
axis tight
title("|L(u,v)-K(u,v)|")
subplot(1,2,2)
surf(U,V,diff2);
axis tight
title("|L(u,v)-Q(u,v)|")


%% trial
img = imread("book-cover.tif");
img = double(imresize(img,[256 256]));
figure
imshow(img,[]);
img_f = fftshift(fft2(img));

figure
res1 = real(ifft2(fftshift(img_f.*(1-L_uv))));
res2 = real(ifft2(fftshift(img_f.*(1-Q_uv))));
res3 = real(ifft2(fftshift(img_f.*(1-K_uv))));
subplot(1,3,1)
imshow(res1,[])
subplot(1,3,2)
imshow(res2,[])
subplot(1,3,3)
imshow(res3,[])

