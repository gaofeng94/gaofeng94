close all;
clc;
%镜像分布函数分析，由于是密排结构
image = imread('example.png');
%\gray = rgb2gray(image);  %灰度
[height,width,channel] = size(image);

rc = width/2; %搜索圆的最大半径
n=1000;  
dr = rc/n;
[centers,particle_num,radius,cordinate_num] = Circle_detect(image);
radius_ave=mean(radius(:,:))
gr = NumPerRadius(centers,rc,dr);
[index,percent] = rdf(height,width,gr,particle_num,dr,radius_ave);

