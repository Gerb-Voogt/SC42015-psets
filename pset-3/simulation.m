clc; clear; close all;

% Setting up simulation parameters
J1 = 10/9;
J2 = 10;
c = 0.1;
k = 1;
kI = 1;
x0 = [0; 0; 0; 0];

% System model
A = [1 0 0 0;
     -k/J1 -c/J1 k/J1 c/J1;
     0 0 1 0;
     k/J2 c/J2 -k/J2 -c/J2];
B = [0 0;
     kI 0;
     0 0;
     0 1];
C = [1 0 0 0;
     0 0 1 0];
D = [0 0;
     0 0];

sys = ss(A, B, C, D);
t = linspace(0,10,1e5);
u = [It(t); sin(t)];
lsim(sys, u, t, x0);
legend;


f = @(t, x) lin_sys(t, x, A, B);
[tout, xout] = ode45(f, [0, 10], x0);


figure;
hold on;
plot(tout, xout(:,1), "LineWidth", 1.5);
plot(tout, sin(tout), "LineWidth", 1.5);
plot(tout, It(tout) , "LineWidth", 1.5);
xlabel("t");
title("Simulation Results");
grid on;
legend("\phi_1", "Td(t)", "I(t)", "Location", "southeast")
saveas(gcf, "./sinusoidal-simulation.png")


function I = It(t)
    J1 = 10/9;
    c = 0.1;
    k = 1;
    % I = -10000/909*exp(-10*t)-100/909*cos(t)+91/909*sin(t);
    I = J1*(c/k*sin(t) + (c/k)^2*cos(t) - exp(-k/c*t)) + ...
        c*(c/k*cos(t) - (c/k)^2*sin(t) + (c/k)*exp(-k/c*t)) + ...
        k*(-c/k*sin(t) - (c/k)^2*cos(t) - (c/k)^2*exp(-k/c*t));
end

function xdot = lin_sys(t, x, A, B)
    % u = [I(t); Td(t)];
    u = [It(t);
         10*sin(t)];
    xdot = A*x + B*u;
end

