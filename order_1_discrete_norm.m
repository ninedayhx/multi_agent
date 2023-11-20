%% 一阶模型离散归一化一致性算法
clear;
close all;
clc;

%% 初始化
% agents的数量
N=4;
% agents初始位置
x0=[0;
    5;
    3;
    9];
% 步长
dt=0.01;
k=0.4;  % K<1/d_max
% 仿真时长
T=1;
t=0:dt:T;
len=length(t);
A=[0 0 1 0;
   1 0 0 1;
   0 1 0 0;
   0 0 1 0];
D=diag(sum(A,2));
L=D-A;
F=(eye(N)+D)^-1*(eye(N)+A)
L_hat = eye(length(x0))-k*L;
%%
x=x0;
y=x0;
for i=1:len
    u(:,i)=-(eye(N)+D)^-1*L*x;
    X(:,i)=x;
    x=F*x;

    u1(:,i)=-k*L*y;
    Y(:,i)=y;
    y=L_hat*y;
    % 由于在本代码的拓扑中，第一个节点被设置为leader
    % （有且仅有一个生成树，且其根部是第一节点），
    % 所以，其他节点都将跟随第一节点，若改变第一节点的位置，
    % 其他节点将表现为跟随
    %x(1,1)=5+5*sin(2*(i/len*T));%正弦波
end

%%
figure(1);
plot(t,X)
title('status');
xlabel('t');
ylabel('status');
legend('x1','x2','x3','x4');
figure(2);
plot(t,u)
xlabel('t');
ylabel('u');
legend('u1','u2','u3','u4');

figure(3);
plot(t,Y)
title('status');
xlabel('t');
ylabel('status');
legend('x1','x2','x3','x4');
figure(4);
plot(t,u1)
xlabel('t');
ylabel('u');
legend('u1','u2','u3','u4');

