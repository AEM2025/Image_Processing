I = imread('A .bmp');
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
gray = rgb2gray(I);
f = im2double(gray);

F = fft2(f);
%get power spectrum to see the noise
%Mag = abs(F).^2; 
%Mag  = mat2gray(log(Mag + 1)); 
%Mag = fftshift(Mag);
%create filter notch filter 
%for remove vertical noise
  H = ones(size(gray));
  x = 2;
  H(255-x:259+x, 190-x:194+x) = 0;
  H(255-x:259+x, 320-x:324+x) = 0;
  H = ifftshift(H);

  filtered = F .* H;
  %for remove Horizontal noise
  
  V = ones(size(gray));
  y = 2;
  V(250-y:252+y, 255-y:257+y) = 0;
  V(270-y:272+y, 255-y:257+y) = 0;
  V = ifftshift(V);
  
  filtered = filtered .* V;
  
  V1 = ones(size(gray));
  y1 = 2;
  V1(22-y1:229+y1, 255-y1:259+y1) = 0;
  V1(280-y1:284+y1, 255-y1:259+y1) = 0;
  V1 = ifftshift(V1);
  
  filtered = filtered .* V1;

  V2 = ones(size(gray));
  y2 = 2;
  V2(215-y2:219+y2, 255-y2:259+y2) = 0;
  V2(290-y2:294+y2, 255-y2:259+y2) = 0;
  V2 = ifftshift(V2);
  
  filtered = filtered .* V2;

%Power Spectrum of filtered
%Mag2 = abs(filtered).^2; 
%Mag2  = mat2gray(log(Mag2 + 1)); 
%Mag2 = fftshift(Mag2);
% Inverese Foruier Transform to convert image to Spatial Domain again
f1 = ifft2(filtered);

subplot(4,2,1), imshow(I),title('Orginal Image');
subplot(4,2,2), imshow(R),title('Red Image');
subplot(4,2,3), imshow(G),title('Green Image');
subplot(4,2,4), imshow(B),title('Blue Image');
subplot(4,2,5), imshow(gray),title('Gray Image');
subplot(4,2,6), imshow(f),title('Double Image');
figure, imshow(f1),title('Final Image');
