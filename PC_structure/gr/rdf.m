function [index,percent] = rdf(height,width,gr,particle_num,dr,radius)
%�����ÿһ��Ȧ���п����ֲ���
[row,col] = size(gr);%row������dr��Ȧ��
percent = zeros(row,1);
gobal_rho = particle_num / (height * width);%��������ܶ�
for i=1:row
    temp = gr(i);
    temp = temp / particle_num;%�����������ͬһ���С�����������Ҫ��ÿ������ƽ������ʾһ�����ÿһ����������
    temp = temp / (pi*((i*dr)^2-((i-1)*dr)^2));%ÿһ����ķֲ��ܶ�
    percent(i) = temp / gobal_rho;%ÿһ����ֲ��ܶ����ȫ���ܶȵı���
end

index = 1:row %����������ľ���
index=index*dr
percent = reshape(percent,1,row);
figure;
%plot(index,percent,'r')
values = spcrv([[index(1) index index(end)];[percent(1) percent percent(end)]],3);
plot(values(1,:),values(2,:), 'r');
xlabel('r/d')
ylabel('gr');
% plot(index,percent,'go');