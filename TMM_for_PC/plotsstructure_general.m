function plotsstructure_general(ref_index,thickness)
%本函数用来画出设计光子晶体介质的折射率结构示意图
%参数说明：layer_num 为介质层数
%thickness_total 为介质层的总厚度
%t1为球的直径，t2为球间距
%n1为球的折射率，n2为介质的折射率
%%
thickness_total=sum(thickness) %薄膜总厚度
layer_num=length(thickness)
layer_index=1:thickness_total %薄膜厚度坐标
height=1:thickness_total  %图像高度
n=ones(thickness_total,thickness_total) %折射率矩阵初始化
j=0
for i=1:layer_num
    j=j+thickness(i,1)
    if i==1
       n(1:thickness(i,1),:)=n(1:thickness(i,1),:)*ref_index(1)
    end
    if i>1
    n(j-thickness(i,1)+1:j,:)=n(j-thickness(i,1)+1:j,:)*ref_index(i)
    end
end
figure(2)
% [p,s] = contourf(layer_index,height,n,1);
% title('设计结构示意图')
% s.LineColor = 'none'
% hold on

pcolor(layer_index,height,n);
shading interp                  %色彩平滑
colormap(hot)         %使用自定义的配色方案
colorbar  
caxis([1.47,1.6])