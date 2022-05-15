clc;
clear;
%{
转移矩阵法计算一维光子晶体的反射率和透射率
%}

%% 输入初始参94数
t1=210 %PS大小 nm
S1=0.1
spacing1=S1*t1  %inplane distance
spacing2=0.1*t1   %cross section 折射率对比随着spacing 的增大而增大
layer_num =2;  %光子晶体层数
grid =1;  %网格间隙，1nm一个间隔
wavelength_start=500; %初始波长
wavelength_stop=600;
in_angle=0/180*3.14;
ref_incident=1; %入射介质折射率
ref_transmission=1; %出射介质折射率

n1=1.59 %PS折射率
n2=1.46 %介质折射率
%生成初始变量
lamda=[wavelength_start:0.2:wavelength_stop]; %生成波长
lamda_num=size(lamda,2); %获得波长的维数

%% 层设置
%% 均匀介质层
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

%% 渐变介质层
%计算一个周期的折射率变化

H=((t1+spacing2)^2-((t1+spacing1)^2)/3)^0.5  %垂直方向球间距
a1=H-(t1/2);  %第一边界
%a1=round(a1)
a2=H/2  %第二边界
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
thickness=ones(layer_num*size(x,2),1); %初始化厚度矩阵
ref_index=zeros(layer_num*size(x,2),1); %初始化折射率矩阵
h=size(x,2)   %每一个聚苯乙烯微球的分的层数
grid_thickness=grid*ones(h,1)
for i=1:layer_num   %设置折射率
    %ref_index(h*(i-1)+i:h*(i-1)+i-1+h,1)=nf
    ref_index(h*(i-1)+1:h*i,1)=nf
end
%% 画出结构图

%figure(2)
index=1:size(ref_index)

%plot(index,ref_index)
%plotsstructure_general(ref_index,thickness)
%% 开始计算 S偏振
%计算入射角度
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

%计算导纳和相位角
eta=zeros(layer_num_total,1)   %初始化导纳矩阵
delta=zeros(layer_num_total,lamda_num)  %初始化相位角矩阵
eta=ref_index.*cos(thetal)
for i= 1:lamda_num %波长
    
     j=1 
     while j<(layer_num_total+1)
     
     delta(j,i)=(2*pi/lamda(i))*ref_index(j)*thickness(j);
     j=j+1;
    end
end
eata_incident=ref_incident*cos(in_angle)   %入射介质的导纳
eata_transmission=ref_transmission*cos(in_angle) %出射介质的导纳
%%开始计算特征矩阵矩阵
R=zeros(lamda_num,1)
for i= 1:lamda_num %波长
    M=1;
    j=1;
    while j<(layer_num_total+1)
    M=M*[cos(delta(j,i))          1i*sin(delta(j,i))/eta(j)
       1i*sin(delta(j,i))*eta(j)  cos(delta(j,i))];
    j=j+1;
    end 
    %%计算反射率
    A=M*[1;eata_transmission];
    b=A(1);
    c=A(2);
    Y=c/b; % 组合导纳
    r=(eata_incident-Y)/(eata_incident+Y);      % 振幅反射系数
    R(i,1)=abs(conj((eata_incident*b-c)/(eata_incident*b+c))*(eata_incident*b-c)/(eata_incident*b+c));    % 能量反射率
    
end
%%开始绘图
figure(3)
plot(lamda,R)
