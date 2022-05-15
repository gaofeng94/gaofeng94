clear;
clc;
close all;
D=200
hh1=0:0.01:0.2  %����
n=size(hh1,2)   
hh2=0:0.01:0.2%����
m=size(hh2,2) 
h2=hh2*D
h1=hh1*D
Vf=zeros(n,m)
V_sphere=3.14*D^3
for i=1:1:n
    for j=1:1:m
     %S=(1.5*(3^0.5))*(D+h1(i))^2  
     S=(1.5*(3^0.5))*(D+h1(i))^2  
     H=2*((D+h2(j))^2-((D+h1(i))^2)/3)^0.5
     V_cell=S*H
     Vf(i,j)=V_sphere/V_cell
    end
end
figure(1)
pcolor(hh2,hh1,Vf);
shading interp                  %ɫ��ƽ��
colormap(hot)         %ʹ���Զ������ɫ����
colorbar 
ylabel('����')
xlabel('����')
figure(2)
plot(hh1,Vf(:,1),hh1,Vf(:,5),hh1,Vf(:,10),hh1,Vf(:,15),hh1,Vf(:,20))
legend(num2str(hh2(1)),num2str(hh2(5)),num2str(hh2(10)),num2str(hh2(15)),num2str(hh2(20)))
ylabel('�������')
xlabel('����')
figure(3)
plot(hh1,Vf(1,:),hh1,Vf(5,:),hh1,Vf(10,:),hh1,Vf(15,:),hh1,Vf(20,:))
legend(num2str(hh2(1)),num2str(hh2(5)),num2str(hh2(10)),num2str(hh2(15)),num2str(hh2(20)))
ylabel('�������')
xlabel('����')
