close all;
clc;
%����ֲ��������������������Žṹ
image = imread('example.png');
%\gray = rgb2gray(image);  %�Ҷ�
[height,width,channel] = size(image);

rc = width/2; %����Բ�����뾶
n=1000;  
dr = rc/n;
[centers,particle_num,radius,cordinate_num] = Circle_detect(image);
radius_ave=mean(radius(:,:))
gr = NumPerRadius(centers,rc,dr);
[index,percent] = rdf(height,width,gr,particle_num,dr,radius_ave);

