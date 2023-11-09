%% part2 try3
clear all;
close all;
clc;
N = 6000;
lambda = 5;
miu = 1/6;
%set up
Infor_matrix = zeros(1,N);%arrive time,waiting time,server time,leaving time
arrive_intvel = exprnd(1/lambda,1,N);
Infor_matrix(1,1) = arrive_intvel(1);
Infor_matrix(2,1) = 0;
Infor_matrix(3,1) = exprnd(miu);
Infor_matrix(4,1) = Infor_matrix(1,1) + Infor_matrix(3,1);
for i = 2:N;
Infor_matrix(1,i) = Infor_matrix(1,i-1)+arrive_intvel(i);
Infor_matrix(3,i) = exprnd(miu);
end

%%
n_arr = 1
n_ser = 1
finished_time = Infor_matrix(4,n_ser);
while n_arr < N;
    if Infor_matrix(1,n_arr+1)<finished_time;
        finished_time = finished_time + Infor_matrix(3,n_arr+1);
        n_arr = n_arr+1;
        n_ser = n_ser+1;
        Infor_matrix(4,n_arr) = finished_time;
    elseif Infor_matrix(1,n_arr+1) > finished_time;
        finished_time = Infor_matrix(1,n_arr+1) + Infor_matrix(3,n_arr+1);
        n_arr = n_arr+1;
        n_ser = n_ser+1;
        Infor_matrix(4,n_arr) = finished_time;
    end
end



time_line = [Infor_matrix(1,:),Infor_matrix(4,:)];

for i = 1:(length(time_line)-1);
    for j = 1:(length(time_line)-i-1);
        if time_line(j)>time_line(j+1);
            a = time_line(j);
            b = time_line(j+1);
            time_line(j) = b;
            time_line(j+1) = a;
        end
    end

end


k = 0;
quene_line = [];
for i = 1:length(time_line);
    k = k +  if_arr_depart(time_line(i),Infor_matrix,N);
    quene_line = [quene_line,k]  ;
end
plot(time_line,quene_line);
A = 0;
for i = 2:length(quene_line);
A = A + (time_line(i)-time_line(i-1))*quene_line(i-1);
end
for i = 1:N
Infor_matrix(2,i) = Infor_matrix(4,i)-Infor_matrix(1,i);
end
aver_quene = A/(time_line(2*N))
rou = lambda*miu;
exptect_quene = rou/(1-rou)
mean(Infor_matrix(2,:))










function [F] = if_arr_depart(b,Infor_matrix,N)
F = -1;
for i = 1:N
    if b == Infor_matrix(1,i)
        F = 1;
    end
end
end