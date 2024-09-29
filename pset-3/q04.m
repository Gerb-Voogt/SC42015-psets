clc; clear; close all;


k = 1;
c = 0.1;
J1 = 10/9;
A = [-c/J1, -k/J1; 0, -k/c];

[l, v] = eig(A)
