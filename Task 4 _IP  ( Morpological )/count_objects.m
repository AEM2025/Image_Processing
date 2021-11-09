function count_objects()
%UNTITLED2 Summary of this function goes here
I = imread('test.png');
imshow(I);
% Fraction of white pixels
[h,w,~] = size(I);
white_per = 0;
black_per = 0;
for R=1:h
    for C=1:w
        if I(R,C) ~= 0
            white_per = white_per + 1;
        else 
            black_per = black_per + 1;
        end    
    end
end
White_fraction = (white_per * 100) / (white_per + black_per);
fprintf('\t (a) Fraction of White pixels = %.4f %% \n',White_fraction);
% Covert image to gray scale 
I = rgb2gray(I);
I = im2bw(I,0.01);
[L ,~] = bwlabel(I);
% stats = regionprops('table',L,'Centroid','MajorAxisLength','MinorAxisLength');
stats1 = regionprops (L,'EulerNumber' , 'ConvexArea' , 'Perimeter' , 'BoundingBox');
% diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
% radii = diameters/2;
se = strel('disk',double(2));
ss = imerode(I,se);
[~ , num] = bwlabel(ss);
fprintf('\t (b) Number of objects in image = %.0f \n',num);
% 0 --> only one hole , -1 --> two holes , 1 --> no holes
obj_no_holes = 0;
num_holes = 0;
for R=1:num
    if ([stats1(R).EulerNumber] == 1)
        obj_no_holes = obj_no_holes + 1;
    end
    if ([stats1(R).EulerNumber] == 0)
        num_holes = num_holes + 1;
    end
    if ([stats1(R).EulerNumber] == -1)
        num_holes = num_holes + 2;
    end   
end
fprintf('\t (c) Number of Holes in image = %.0f \n',num_holes);
fprintf('\t (d) Number of objects That have holes = %.0f \n',num - obj_no_holes);

%I2 = imfill(ss,'holes');
% figure,imshow(I2);

num_circles = 0;

for R=1:num
%        h = uint8 (stats1(R).BoundingBox(3));
%        w = uint8 (stats1(R).BoundingBox(4));
%     if (I(x,y) == 255)
%         sum = sum + 1;
%         bb = stats1(R).BoundingBox;
%         rectangle('position',bb,'edgecolor','r','linewidth',1.3);
%     end
% check circularity TO detect all circles in the image
        circularity = (stats1(R).Perimeter .^ 2) ./ (4 * pi * stats1(R).ConvexArea);
        if (circularity < 1.1)
            num_circles = num_circles + 1;
            if ([stats1(R).EulerNumber] == 1)
                bb = stats1(R).BoundingBox;
                rectangle('position',bb,'edgecolor','y','linewidth',3);
            end
        else
            if ([stats1(R).EulerNumber] < 1)
                bb = stats1(R).BoundingBox;
                rectangle('position',bb,'edgecolor','b','linewidth',3);
            end
        end
end
fprintf('\t (d) Number of Squares = %.0f \n',num - num_circles);
fprintf('\t (g) Number of Circles = %.0f \n',num_circles);



% (a) What fraction of the image pixels is white?
% (b) How many objects are in the image?
% (c) How many holes are in the image?
% (d) How many objects have one or more holes?

% (e) How many square objects are in the image?
% (f) Identify the square objects that have holes.
% (g) Identify the circular objects that have no holes.

end

