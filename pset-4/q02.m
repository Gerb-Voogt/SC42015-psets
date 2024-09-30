clc; clear; close all;

A = [-1, 1, 0, 0;
    0, -1, 0, 0;
    0, 0, 0, 1;
    0, 0, 0, 0];
B = [1; 1; 1; 1];

a1 = 2;
a2 = 1;
a3 = 0;

S1 = B;
S2 = (A + a1*eye(4))*B;
S3 = (A^2 + a1*A + a2*eye(4))*B;
S4 = (A^3 + a1*A^2 + a2*A + a3*eye(4))*B;

S = [S1, S2, S3, S4]
Sinv = inv(S)

Atilde = Sinv*A*S
Btilde = Sinv*B

Ftilde = [10, 53, 108, 81];
F = Ftilde*Sinv

Acl = A-B*F;
eig(Acl)
