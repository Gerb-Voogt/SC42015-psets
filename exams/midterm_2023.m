clc; clear; close all;

A = [-1, 0;
     1, -2];
B = [0;
     2];

Tf = 2;

J = [-2, 0;
     0, -1];
S = [0, 1;
     1, 1];
Sinv = inv(S);

res1 = S*expm(J*Tf)*Sinv
res2 = expm(A*Tf)

res3 = Sinv*expm(J*Tf)*S
res4 = expm(A'*Tf)
