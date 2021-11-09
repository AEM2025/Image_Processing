function [ s ] = extract_man(img1)
%EDGEBASED Summary of this function goes here
%Read image first
I = imread(img1);
%save size of image because we will need it to loop over image to convert it to RGB
[h, w, ~] = size(I);
%Save Values for R , G, B and subtract B from max (R, G) but why ? because we want to remove blue background , to reduc Noise
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
ae = double(double(B) - double(max(G,R)));
new_img = double(ae < 25);
%apply noise removal to remove all noise from picture
x = imgaussfilt(new_img, 0.1);
% image after delete background , so you will have three objects only Man + Mountain 
figure,imshow(x);
%Apply edge detection to detect man edges 
BW = edge(x,'canny');
% complete edges 
se = strel('square', 5);
%higlight edges 
BW = imdilate(BW,se);
BW = ~BW;
% inverese picture because we need objects only be white , num = number of objects  
[L, num] = bwlabel(BW);

% we don't need to convert image here 
% col_img =label2rgb(L);
% figure,imshow(col_img);

smallRatio = h * w * 0.002;
d = zeros(size(I));
for i=1:num
    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < smallRatio)
        continue;
    end
    if (i == 3)
        d(:,:,1) = uint8(x).* I(:,:,1);
        d(:,:,2) = uint8(x).* I(:,:,2);
        d(:,:,3) = uint8(x).* I(:,:,3);
    end
end
figure, imshow(uint8(d))

% We have a problem here because they may change picture resolution
%imwrite(uint8(d),'New_image.png')

add_man(d,'Background.jpg')
end

