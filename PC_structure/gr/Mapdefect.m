function [cordinate_num]=Mapdefect(image)
%function���������ͼ���Բ
%input:image:���ڼ��Բ��ͼƬ��ɫͼƬ
%output:centers:��⵽��Բ��Բ�����ꣻparticle_num:��⵽ͼ����Բ������

gray = rgb2gray(image);  %�ҶȻ�
bw = imbinarize(gray);   %��ֵ��
bw_inverse = imcomplement(bw); %��ֵͼ��ת����0��1,1��0
[centers,radius] = imfindcircles(bw_inverse,[5,20]); %���ͼ���ϰ뾶��5~20֮���Բ��Ҳ��������������ʵ�������Ҫ
%��ʾͼ��
figure;
imshow(bw_inverse);
hold on;
viscircles(centers,radius,'EdgeColor','b');
[row,col] = size(centers);
cordinate_num=zeros(row,1);
radius_ave=mean(radius(:))

for i=1:(row-1)
    for j = i+1:row
        distance = sqrt((centers(i,1)-centers(j,1))^2 + (centers(i,2)-centers(j,2))^2);
        if distance <= 2.5*radius_ave
            cordinate_num(i) = cordinate_num(i)+1;
            cordinate_num(j) = cordinate_num(j)+1;
        end
    end
end

for i=1:row
    if cordinate_num(i)==4
        viscircles(centers(i,:),radius(i,1),'EdgeColor','b');
    end
    if cordinate_num(i)==5
        viscircles(centers(i,:),radius(i,1),'EdgeColor','r');
    end
end 

