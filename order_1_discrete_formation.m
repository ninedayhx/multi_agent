%% 一阶模型离散编队算法
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
% agent之间的间距
H=[0;
   0; 
   0; 
   0];
% 间距矩阵
H_hat = H*ones(1,N)-(H*ones(1,N))'
% 步长
dt=0.01;
% 仿真时长
T=4;
t=0:dt:T;
len=length(t);
A=[0 0 0 0;
   1 0 0 0;
   0 1 0 0;
   0 0 1 0];
D=diag(sum(A,2));
L=D-A;
k=0.1;
L_hat = eye(length(x0))-k*L

%%
x=x0;
for i=1:len
    u(:,i)=k*(-L*x+A.*H_hat*ones(length(x0),1));
    X(:,i)=x;
    x=L_hat*x+k*A.*H_hat*ones(length(x0),1);
    % 由于在本代码的拓扑中，第一个节点被设置为leader
    % （有且仅有一个生成树，且其根部是第一节点），
    % 所以，其他节点都将跟随第一节点，若改变第一节点的位置，
    % 其他节点将表现为跟随
    x(1,1)=5+5*sin(2*(i/len*T));%正弦波
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

