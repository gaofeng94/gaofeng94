function [centers,particle_num,radius,cordinate_num] = Circle_detect(image)
%function：检测输入图像的圆
%input:image:用于检测圆的图片彩色图片
%output:centers:检测到的圆的圆心坐标；particle_num:检测到图像上圆的总数

gray = rgb2gray(image);  %灰度化
bw = imbinarize(gray);   %二值化
bw_inverse = imcomplement(bw); %二值图像反转，即0变1,1变0
[centers,radius] = imfindcircles(bw_inverse,[5,20],'EdgeThreshold',0); %检测图像上半径在5~20之间的圆，也可以是其它，看实际情况需要
particle_num = length(radius(:)); %统计圆的个数

[row,col] = size(centers);
cordinate_num=zeros(row,1);
radius_ave=mean(radius(:))

for i=1:(row-1)
    for j = i+1:row
        distance = sqrt((centers(i,1)-centers(j,1))^2 + (centers(i,2)-centers(j,2))^2);
        if distance <= 2.8*radius_ave
            cordinate_num(i) = cordinate_num(i)+1;
            cordinate_num(j) = cordinate_num(j)+1;
        end
    end
end
figure;
imshow(bw_inverse);
hold on;
% viscircles(centers,radius,'EdgeColor','b');
% mapdefect
%根据配位数改变探测圆形的颜色
for i=1:row
    if cordinate_num(i)<=5
        viscircles(centers(i,:),radius(i,1),'Color','g','LineWidth',1);  
    end
    if cordinate_num(i)==6
        viscircles(centers(i,:),radius(i,1),'EdgeColor','b','LineWidth',1);
    end
    if cordinate_num(i)>=7
        viscircles(centers(i,:),radius(i,1),'EdgeColor','r','LineWidth',1);
    end
end
%显示图像

