%% 一阶模型离散一致性算法
clear;
close all;
clc;

%% 初始化
x0=[10;
    2;
    3;
    4];
% 步长
dt=0.01;
% 仿真时长
T=2;
t=0:dt:T;
n=length(t);
A=[0 0 0 0;
   1 0 0 0;
   0 1 0 0;
   0 0 1 0];
D=diag(sum(A,2));
L=D-A;
k=0.1;
L_hat = eye(length(x0))-k*L;

%%
x=x0;
for i=1:n
    u(:,i)=-k*L*x;
    X(:,i)=x;
    x=L_hat*x;
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

