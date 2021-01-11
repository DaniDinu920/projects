I=imread('pica.png');
imshow(I)
title('Input Image');
key=zeros(1,64);
I1=rgb2gray(I);
figure,imshow(I1);
I1=double(I1);
[nr,nc]=size(I1);
I1=transpose(I1);
PRNG=256;
I1=reshape(I1,1,[]);
padsize=64-mod(length(I1),64);%dim padding-ului
I2=[I1 zeros(1,padsize)];%imaginea dupa padding
I3=zeros(1,length(I2));%textul criptat 
for y=1:64:(length(I2-64))
    block=I2(1,y:y+63);
    PRNG=lfsr(PRNG);
    block=Cipher(key,block,PRNG);
    block=transpose(block);
    block=reshape(block,1,[]);
    I3(1,y:y+63)=block;
end
Cim=I3(1,1:(length(I3)-padsize));
Cim=reshape(Cim,nc,nr)';
Cim=uint8(Cim)
figure,imhist(Cim);
%rgbimage=gray2rgb(Cim);
figure,imshow(Cim);
colormap jet
%figure,imshow(Cim)
%title('gray converted Image')