%��������Լ���������������ı仯�����Ӿ������ı仯

clear;
clc;
close all;
D=210  %���׿�������
hh1=0.1 %���ڼ��
  
hh2=0:0.01:0.2% ��������
m=size(hh2,2) 
h2=hh2*D
h1=hh1*D
Vf=zeros(m,1)
H=zeros(m,1)
V_sphere=3.14*D^3
for i=1:1:m
     H(i)=((D+h2(i))^2-((D+h1)^2)/3)^0.5   %�������
end
figure(1)
plot(hh2,H/D)    

