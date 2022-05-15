function gr = NumPerRadius(centers,rc,dr)
%grͳ���˾�������ԭ��ÿһ��ԭ�ӵ�����
[row,col] = size(centers);
num = round(rc/dr);
gr=zeros(num,1);%����

for i=1:(row-1)
    for j = i+1:row
        distance = sqrt((centers(i,1)-centers(j,1))^2 + (centers(i,2)-centers(j,2))^2);
        if distance <= rc
            lane = round(distance/dr);
            gr(lane) = gr(lane)+1; %ͳ�ƾ�������ԭ��ÿһ��ԭ�ӵ�����
        end
    end
end


