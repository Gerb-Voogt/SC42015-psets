clc; clear; close all;


A = [3, 5, 5;
     -3, -5, -3;
     1, 2, 2];
B = [-3; 
     2;
     -1];

coef = charpoly(A);
alpha_1 = coef(2);
alpha_2 = coef(3);

S1 = B;
S2 = (A + alpha_1*eye(3))*B;
S3 = (A^2 + alpha_1*A + alpha_2*eye(3))*B;

S = [S1, S2, S3]
T = inv(S)

Atilde = T*A*inv(T)
Btilde = T*B

syms l f1 f2 f3;
Ftilde = [f1, f2, f3];
sys = [-f1-l, 3-f2, -f3-2;
       1, -l, 0;
       0, 1, -l];
det(sys)

Ftilde = [6, 15, 6];
sys_cl = Atilde - Btilde*Ftilde;


F = Ftilde*T
eig(A - B*F)



A = [-1, 1, -2;
     0, 2, -4;
     -1/2, 3/2, -3];
charpoly(A)
