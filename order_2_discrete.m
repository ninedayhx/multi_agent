%% 连续二阶系统一致性算法
clear;
close all;
clc;
%%
% num of agent
N = 4;
n = 2;
% init param
p0 = [1;
      2; 
      3;
      4];
v0 = [5;
      0;
      1;
      0];
X0 = [1;5;2;0;3;1;4;0];
% LTI
A = [0 1;
     0 0];
B = [0;
     1];
% graph topology
A_g = [0 0 0 0;
       1 0 0 0;
       0 1 0 0;
       0 0 1 0];
D_g = diag(sum(A_g,2));
L_g = D_g - A_g;
% step 
T = 2;
dt = 0.01;
t = 0:dt:T;
len = length(t);
% feedback 
c = 0.1;
f = 1;
K=[1 0.1];

%% iterative loop
X = X0;
for i = 1:len
    U_log(:,i) = -c*kron(L_g,K)*X;
    X_log(:,i) = X;
    X = (kron(eye(N),A+eye(n))-c*kron(L_g,B*K))*X;
end

%% figure
%P_log = X
t = 0:dt:T;
figure(1)
plot(t,X_log(1:2:7,:));
xlabel("t/s");
ylabel("position");
legend("p1","p2","p3","p4");
title("位置曲线")
figure(2)
plot(t,X_log(2:2:8,:));
xlabel("t/s");
ylabel("velocity");
legend("v1","v2","v3","v4");
title("速度曲线")
figure(3)
plot(t,U_log);
xlabel("t/s");
ylabel("accelerate");
legend("a1","a2","a3","a4");








