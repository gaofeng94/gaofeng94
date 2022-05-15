function [index,percent] = rdf(height,width,gr,particle_num,dr,radius)
%计算的每一个圈层中颗粒分布的
[row,col] = size(gr);%row代表了dr的圈数
percent = zeros(row,1);
gobal_rho = particle_num / (height * width);%总体颗粒密度
for i=1:row
    temp = gr(i);
    temp = temp / particle_num;%这是所有球的同一层的小球总量，因此要对每个球求平均，表示一个球的每一层的球的数量
    temp = temp / (pi*((i*dr)^2-((i-1)*dr)^2));%每一层球的分布密度
    percent(i) = temp / gobal_rho;%每一层球分布密度相对全局密度的比例
end

index = 1:row %代表了离球的距离
index=index*dr
percent = reshape(percent,1,row);
figure;
%plot(index,percent,'r')
values = spcrv([[index(1) index index(end)];[percent(1) percent percent(end)]],3);
plot(values(1,:),values(2,:), 'r');
xlabel('r/d')
ylabel('gr');
% plot(index,percent,'go');