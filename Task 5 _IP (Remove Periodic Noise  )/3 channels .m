I = imread('A .bmp');
%gray = rgb2gray(I);
%f = im2double(gray);
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
FR = fft2(R);
FG = fft2(G);
FB = fft2(B);
%get power spectrum to see the noise
%Mag = abs(F).^2; 
%Mag  = mat2gray(log(Mag + 1)); 
%Mag = fftshift(Mag);
%create filter notch filter 
%for remove vertical noise
  H = ones(size(R));
  x = 2;
  H(255-x:259+x, 190-x:194+x) = 0;
  H(255-x:259+x, 320-x:324+x) = 0;
  H = ifftshift(H);

  filteredr = FR .* H;
  filteredg = FG .* H;
  filteredb = FB .* H;
  %for remove Horizontal noise
  
  V = ones(size(R));
  y = 2;
  V(250-y:252+y, 255-y:257+y) = 0;
  V(270-y:272+y, 255-y:257+y) = 0;
  V = ifftshift(V);
  
  filteredr = filteredr .* V;
  filteredg = filteredg .* V;
  filteredb = filteredb .* V;
  V1 = ones(size(R));
  y1 = 2;
  V1(22-y1:229+y1, 255-y1:259+y1) = 0;
  V1(280-y1:284+y1, 255-y1:259+y1) = 0;
  V1 = ifftshift(V1);
  
  filteredr = filteredr .* V1;
  filteredg = filteredg .* V1;
  filteredb = filteredb .* V1;
  
  V2 = ones(size(R));
  y2 = 2;
  V2(215-y2:219+y2, 255-y2:259+y2) = 0;
  V2(290-y2:294+y2, 255-y2:259+y2) = 0;
  V2 = ifftshift(V2);
  
  filteredr = filteredr .* V2;
  filteredg = filteredg .* V2;  
  filteredb = filteredb .* V2;
  
%Power Spectrum of filtered
%Mag2 = abs(filtered).^2; 
%Mag2  = mat2gray(log(Mag2 + 1)); 
%Mag2 = fftshift(Mag2);
% Inverese Foruier Transform to convert image to Spatial Domain again
f1 = ifft2(filteredr);
f2 = ifft2(filteredg);
f3 = ifft2(filteredb);
imgRGB = cat(3, R, G, B);

subplot(2,4,1), imshow(I),title('Orginal Image');
subplot(2,4,2), imshow(R),title('Red Image');
subplot(2,4,3), imshow(G),title('Green Image');
subplot(2,4,4), imshow(B),title('Blue Image');
subplot(2,4,5), imshow(f1),title('Red image');
subplot(2,4,6), imshow(f2),title('Green image');
subplot(2,4,7), imshow(f3),title('Blue image');
subplot(2,4,8), imshow(imgRGB),title('Final');
