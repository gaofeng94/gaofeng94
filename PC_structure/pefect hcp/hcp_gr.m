close all;
clc;
radius=16;
num=900;
height=1066;
width=1066;
rc = width/2; %����Բ�����뾶
n=1000;  
dr = rc/n;
[centers]=draw_perfect_hcp(radius,num,height,width)
gr = NumPerRadius(centers,rc,dr);
[index,percent] = rdf(height,width,gr,num,dr,radius);

