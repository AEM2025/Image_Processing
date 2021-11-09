function [ bits ] = DetectUselessBits( img , per )
%UNTITLED Summary of this function goes here
% read an image from Pc
image = imread(img);
% Convert it to gray scale but we can skip this line because image is gray
gray_image = rgb2gray(image);
%Calculate the percentage 
[h,w]=size(gray_image);
percen = h * w * per;
%Loop to iterate over the 8 bits and calculate percentage for each bit
bits=[];
ii=1;
sum=0;
k=1;
for i=[1:8]
    for m=[1:h]
        for n=[1:w]
            bi=bitand(gray_image(m,n), k);
            if bi>0
                sum = sum+1;
            end
        end
    end
    k=k*2;
    if sum<percen
        bits(ii)=i;
        ii=ii+1;
    end
sum =0;
end
end

