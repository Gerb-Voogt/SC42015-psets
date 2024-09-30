clc; clear; close all;
% x = [phi_1, dphi_1/dt, phi_2, dphi_2/dt]^T
% y = [phi_1, phi_2]^T
% u = [I, Td]^T

J1 = 10/9;
J2 = 10;
c = 0.1;
k = 1;
kI = 1;

% Defining the system Matrices
A = [0, 1, 0, 0;
     -k/J1, -c/J1, k/J1, c/J1;
     0, 0, 0, 1;
     k/J2, c/J2, -k/J2, -c/J2]
B = [0, 0;
     kI, 0;
     0, 0;
     0, 1];
C = [1, 0, 0, 0;
     0, 0, 1, 0];
D = zeros(2, 2);

% Checking the controllability from I as well as Td
rank(ctrb(A, B(:,1)))
rank(ctrb(A, B(:,2)))

% Find open loop poles
eig(A)

% Place the poles and check the resulting locations from the state feedback controller K
desired_poles = [-2, -1, -1+j, -1-j];
K = place(A, B, desired_poles)
Acl = A - B*K;
eig(Acl)

% Make a state-space object to simplify simulations
sys = ss(Acl, B, C, D);

% Simulate for various initial conditions
x01 = [1, 0, 1, 0];
x02 = [0, 1, 0, 1];
x03 = [1, 1, 1, 1];
t = linspace(0, 10);
u = zeros(2, length(t));
[yout1, ~] = lsim(sys, u, t, x01);
[yout2, ~] = lsim(sys, u, t, x02);
[yout3, ~] = lsim(sys, u, t, x03);

% Plotting the perturbed initial conditions
figure; 
sgtitle("Closed loop simulation for various initial conditions")
subplot(2, 1, 1); hold on;
grid on;
title("\phi_1")
ylabel("Amplitude")
xlabel("t [s]")
plot(t, yout1(:,1), "LineWidth", 1.5)
plot(t, yout2(:,1), "LineWidth", 1.5)
plot(t, yout3(:,1), "LineWidth", 1.5)
subplot(2, 1, 2); hold on;
grid on;
title("\phi_2")
ylabel("Amplitude")
xlabel("t [s]")
plot(t, yout1(:,2), "LineWidth", 1.5)
plot(t, yout2(:,2), "LineWidth", 1.5)
plot(t, yout3(:,2), "LineWidth", 1.5)
legend("x0 = [1, 0, 1, 0]", "x0 = [0, 1, 0, 1]", "x0 = [1, 1, 1, 1]")
saveas(gcf, "./simulation-initial-conditions.png");

% Simulate for a disturbance step on the torque of rotor 2
x0 = [0, 0, 0, 0];
u = zeros(2, length(t));
u(2, :) = 1;
[yout4, ~] = lsim(sys, u, t, x0);

% Plotting the disturbance step
figure; 
sgtitle("Closed loop simulation for a step input on the system torque Td")
subplot(2, 1, 1); hold on;
grid on;
title("\phi_1")
ylabel("Amplitude")
xlabel("t [s]")
plot(t, yout4(:,1), "LineWidth", 1.5)
subplot(2, 1, 2); hold on;
grid on;
title("\phi_2")
ylabel("Amplitude")
xlabel("t [s]")
plot(t, yout4(:,2), "LineWidth", 1.5)
saveas(gcf, "./simulation-disturbance-step.png");

% Computing the DCgain matrix for the torque input
gain_matrix = dcgain(sys);
gain_matrix(:,2)
