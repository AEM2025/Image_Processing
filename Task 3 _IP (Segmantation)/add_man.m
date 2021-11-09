function  add_man( img1 , img2 )

%Detailed explanation goes here
% Read background + man images first 
img = imread(img2);
sz = size(img1);
%Resize background image to be the same size of man image 
img = imresize(img,sz(1:2));
[h,w,~] = size(img);
%add man to background image , why ~= 0 ? because we need man only without black background
for R=1:h
    for C=1:w
        if(img1(R,C) ~= 0)
            img(R,C,1) = img1(R,C,1);
            img(R,C,2) = img1(R,C,2);
            img(R,C,3) = img1(R,C,3);
        end
    end
end

figure,imshow(img)
imwrite(img,'Man With Background.png')

end

