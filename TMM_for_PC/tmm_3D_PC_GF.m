clc;
clear;
%{
ת�ƾ��󷨼���һά���Ӿ���ķ����ʺ�͸����
%}

%% �����ʼ��94��
t1=210 %PS��С nm
S1=0.1
spacing1=S1*t1  %inplane distance
spacing2=0.1*t1   %cross section �����ʶԱ�����spacing �����������
layer_num =2;  %���Ӿ������
grid =1;  %�����϶��1nmһ�����
wavelength_start=500; %��ʼ����
wavelength_stop=600;
in_angle=0/180*3.14;
ref_incident=1; %�������������
ref_transmission=1; %�������������

n1=1.59 %PS������
n2=1.46 %����������
%���ɳ�ʼ����
lamda=[wavelength_start:0.2:wavelength_stop]; %���ɲ���
lamda_num=size(lamda,2); %��ò�����ά��

%% ������
%% ���Ƚ��ʲ�
% thickness=ones(layer_num,1)
% ref_index=ones(layer_num,1)
% for i=1:layer_num/2
%    thickness(2*i-1)=thickness(2*i-1)*t1
%    thickness(2*i)=thickness(2*i)*t2
%    ref_index(2*i-1)=ref_index(2*i-1)*n1
%    ref_index(2*i)=ref_index(2*i)*n2
%     
% end
% thickness_total=sum(thickness)
% 
%plotsstructure(layer_num,thickness_total,t1,t2,n1,n2)
%plotsstructure_general(ref_index,thickness)

%% ������ʲ�
%����һ�����ڵ������ʱ仯

H=((t1+spacing2)^2-((t1+spacing1)^2)/3)^0.5  %��ֱ��������
a1=H-(t1/2);  %��һ�߽�
%a1=round(a1)
a2=H/2  %�ڶ��߽�
%a2=round(a2)
x1=0:grid:a1
x2=a1+grid:grid:a2
f1=(((t1/2)^2-x1.^2)*3.14/2)/((3^0.5)/4*((t1+spacing1)^2))
%f2=(((t1/2)^2-x2.^2)*3.14/2)+((t1/2)^2-(t1/2-(x2-a1)).^2)*3.14
f2=(((t1/2)^2-x2.^2)*3.14/2)+((t1/2)^2-(t1/2-(x2-a1)).^2)*3.14
f2=f2/((3^0.5)/4*((t1+spacing1)^2))
f=[f1 f2]
nf_1=(f*n1^2+(1-f)*n2^2).^0.5
nf_2=fliplr(nf_1)
nf=[nf_2,nf_1]
figure(1)
x=[x1 x2]
x=0:1:2*size(x,2)-1
x=x*grid
plot(x,nf)
thickness=ones(layer_num*size(x,2),1); %��ʼ����Ⱦ���
ref_index=zeros(layer_num*size(x,2),1); %��ʼ�������ʾ���
h=size(x,2)   %ÿһ���۱���ϩ΢��ķֵĲ���
grid_thickness=grid*ones(h,1)
for i=1:layer_num   %����������
    %ref_index(h*(i-1)+i:h*(i-1)+i-1+h,1)=nf
    ref_index(h*(i-1)+1:h*i,1)=nf
end
%% �����ṹͼ

%figure(2)
index=1:size(ref_index)

%plot(index,ref_index)
%plotsstructure_general(ref_index,thickness)
%% ��ʼ���� Sƫ��
%��������Ƕ�
layer_num_total=length(thickness)
thetal=ones(layer_num_total,1)
for i=1:layer_num_total
    if i==1
        thetal(i,1)=asin((ref_incident*sin(in_angle))./ref_index(i,1));
    end 
    if i>1
    thetal(i,1)=asin((ref_index(i-1,1)*sin(thetal(i-1,1)))./ref_index(i,1));
    end
end

%���㵼�ɺ���λ��
eta=zeros(layer_num_total,1)   %��ʼ�����ɾ���
delta=zeros(layer_num_total,lamda_num)  %��ʼ����λ�Ǿ���
eta=ref_index.*cos(thetal)
for i= 1:lamda_num %����
    
     j=1 
     while j<(layer_num_total+1)
     
     delta(j,i)=(2*pi/lamda(i))*ref_index(j)*thickness(j);
     j=j+1;
    end
end
eata_incident=ref_incident*cos(in_angle)   %������ʵĵ���
eata_transmission=ref_transmission*cos(in_angle) %������ʵĵ���
%%��ʼ���������������
R=zeros(lamda_num,1)
for i= 1:lamda_num %����
    M=1;
    j=1;
    while j<(layer_num_total+1)
    M=M*[cos(delta(j,i))          1i*sin(delta(j,i))/eta(j)
       1i*sin(delta(j,i))*eta(j)  cos(delta(j,i))];
    j=j+1;
    end 
    %%���㷴����
    A=M*[1;eata_transmission];
    b=A(1);
    c=A(2);
    Y=c/b; % ��ϵ���
    r=(eata_incident-Y)/(eata_incident+Y);      % �������ϵ��
    R(i,1)=abs(conj((eata_incident*b-c)/(eata_incident*b+c))*(eata_incident*b-c)/(eata_incident*b+c));    % ����������
    
end
%%��ʼ��ͼ
figure(3)
plot(lamda,R)
