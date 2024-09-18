clc; clear; close all;

% Functions
k = @(q) 0.2*q + q^3;
c = @(v) 1e-4*atan(v);
k_prime = @(q) 0.2 + 3*q^2;
c_prime = @(v) 1e-4/(1+v^2);


J1 = 5e-6;
J2 = J1;
kI = 1;

% Find the roots of polynomial for possible equilibrium values of phi1
p = [1, 0, 0.2, -1];
sol = roots(p);

% Setting the equilibrium state
phi1e = real(sol(imag(sol) == 0)); % Select only real root
phi2e = 0;
phi1dote = 0;
phi2dote = 0;

x_eq = [phi1e; phi1dote; phi2e; phi2dote];
u_eq = [1; k(phi1e)];

Aeq = [0, 1, 0, 0;
       -1/J1*k_prime(phi1e - phi2e), -1/J1*c_prime(phi1dote - phi2dote), 1/J1*k_prime(phi1e-phi2e), 1/J1*c_prime(phi1dote - phi2dote);
       0, 0, 0, 1;
       1/J2*k_prime(phi2e - phi1e), 1/J2*c_prime(phi2dote - phi1dote), -1/J2*k_prime(phi2e-phi1e), -1/J2*c_prime(phi2dote - phi1dote)];
eigenvalues_of_Aeq = eig(Aeq)
