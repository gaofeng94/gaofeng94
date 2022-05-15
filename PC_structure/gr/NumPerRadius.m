function gr = NumPerRadius(centers,rc,dr)
%gr统计了距离中心原子每一层原子的数量
[row,col] = size(centers);
num = round(rc/dr);
gr=zeros(num,1);%层数

for i=1:(row-1)
    for j = i+1:row
        distance = sqrt((centers(i,1)-centers(j,1))^2 + (centers(i,2)-centers(j,2))^2);
        if distance <= rc
            lane = round(distance/dr);
            gr(lane) = gr(lane)+1; %统计距离中心原子每一层原子的数量
        end
    end
end


