clc; clear; close all;

A = [-1, 0;
    -3, -2];
B = [1;
    -3];

C = ctrb(A, B);

rank(ctrb(A, B))
L = diag(eig(A))

% Diagonaliziation
S = [0, -1/3;
     1, 1];
Sinv = inv(S)

syms t
expm(A*t)
expAT = S*expm(L*t)*Sinv

syms c1 t T

int(expm(A*(T-t))*B*c1)




