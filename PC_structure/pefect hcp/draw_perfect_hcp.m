function [centers] = draw_perfect_hcp(radius,num,paper_height,paper_width)
%radius=16;
%num=1200
centers=zeros(num,2);
height=paper_height;
width=paper_width
n=1.1 %放大参数
num_per_line=round(width/(2*radius));
k=0

spacing=n*radius
for i=1:15
    for j=1:30
        k=k+1
        centers(k,1)=2*(3^0.5)*(i-1)*spacing   %行
        centers(k,2)=2*(j-1)*spacing   %列     
    end
end
for i=1:15
    for j=1:30
        k=k+1
        centers(k,1)=2*(3^0.5)*(i-1)*spacing+spacing*3^0.5 %行
        centers(k,2)=2*(j-1)*spacing+spacing %列    
    end
end

figure;
xlim([0 height])
ylim([0 width])
for i=1:num
    viscircles(centers(i,:),radius,'EdgeColor','r','LineWidth',1);
end
