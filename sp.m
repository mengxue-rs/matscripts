% matlab script about spectral pooling
% code by snow 1/22/2019
% mengxue_zhang@outlook.com

%% input
clear;clc;
% size = 7;
% v = randn(size, size);
size = 400;
v = im2double(rgb2gray(imresize(imread('peppers.png'), [size, size])));
fv = fft2(v);
fv_s = fftshift(fv);
fa = 81;

%% run sp pooling operation
mid = ceil((size+1)/2);
b = mid - floor(fa/2);
e = b + fa - 1;
fv_cut = fv_s(b:e, b:e);
if mod(fa, 2) == 0
    if fa ~= size
        c = fa / 2;
        % real constraints
        fv_cut(1,1)= 0; fv_cut(1, c+1) = abs(fv_cut(1, c+1));
        fv_cut(c+1, 1) = abs(fv_cut(c+1, 1));
        fv_cut(c+1, c+1) = abs(fv_cut(c+1, c+1));
        % conjugate constraints
        for i = 2:fa
            if i ~= c+1
                fv_cut(1, i) = 0 ;
                fv_cut(i, 1) = 0;
            end
        end
    end
else
    c = (fa+1)/2;
    fv_cut(c, c) = abs(fv_cut(c, c));     
end

%% output
fv_c = ifftshift(fv_cut);
out = ifft2(fv_c);
imtool(mat2gray(out));