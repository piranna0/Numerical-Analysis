% Script A1JPEG
% Used to check out JPEG and IJPEG. 
close all
% Read in an image and display it..
A = imread('GoldenGate.jpg');            
imshow(A)
% The layers of A are matrices that encode the rgb values...
[m,n,p] = size(A);
% Extract the rgb matrices and convert to double...
Red   = double(A(:,:,1));
Green = double(A(:,:,2));
Blue  = double(A(:,:,3));
% Apply JPEG compression and compute compression ratio...
RedJ = JPEG(Red);
compFactor_RedJ = (m*n)/sum(sum(RedJ>0));
GreenJ = JPEG(Green);
compFactor_GreenJ = (m*n)/sum(sum(GreenJ>0));
BlueJ = JPEG(Blue);
compFactor_BlueJ = (m*n)/sum(sum(BlueJ>0));
% Decompress...
R = IJPEG(RedJ);
G = IJPEG(GreenJ);
B = IJPEG(BlueJ);
% Assemble into a color picture array..
MyA = zeros(m,n,3,'uint8');
MyA(:,:,1) = uint8(R);
MyA(:,:,2) = uint8(G);
MyA(:,:,3) = uint8(B);
% and display...
figure
imshow(MyA)
s = sprintf('Compression Factors: Red = %5.2f  Green = %5.2f  Blue = %5.2f',...
    compFactor_RedJ,compFactor_GreenJ,compFactor_BlueJ);
title(s,'fontsize',14)
% IJPEG should pretty much reverese what JPEG does. So imshow(A) and
% imshow(MyA) should look the same.




