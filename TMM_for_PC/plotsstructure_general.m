function plotsstructure_general(ref_index,thickness)
%����������������ƹ��Ӿ�����ʵ������ʽṹʾ��ͼ
%����˵����layer_num Ϊ���ʲ���
%thickness_total Ϊ���ʲ���ܺ��
%t1Ϊ���ֱ����t2Ϊ����
%n1Ϊ��������ʣ�n2Ϊ���ʵ�������
%%
thickness_total=sum(thickness) %��Ĥ�ܺ��
layer_num=length(thickness)
layer_index=1:thickness_total %��Ĥ�������
height=1:thickness_total  %ͼ��߶�
n=ones(thickness_total,thickness_total) %�����ʾ����ʼ��
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
% title('��ƽṹʾ��ͼ')
% s.LineColor = 'none'
% hold on

pcolor(layer_index,height,n);
shading interp                  %ɫ��ƽ��
colormap(hot)         %ʹ���Զ������ɫ����
colorbar  
caxis([1.47,1.6])