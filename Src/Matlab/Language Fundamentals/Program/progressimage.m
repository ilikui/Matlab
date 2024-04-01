function [] = progressimage()

[name,path] = uigetfile({'*.png','请选择一张图片(*.png)'},'请打开一张png图片');

file = strcat(path,name);
[I,map] = imread(file);
if(size(I,3)) == 3
    I = double(rgb2gray(I));
end

I1 = I-100;
sign1 = sign(I1);
coef1 = (sign1+abs(sign1))/2;

I1 = I.*coef1;
I2 = I.*(1-coef1);

I1 = uint8((I1/max(max(I1)))*255);
I2 = uint8((I2/max(max(I2)))*255);
figure;
h1 = subplot(1,2,1);
imshow(I1);
h2=subplot(1,2,2);
imshow(I2);


truesize;



end