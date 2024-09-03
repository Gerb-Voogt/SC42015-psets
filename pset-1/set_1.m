% Defining the linear state space model
A = [-2, -4, -6;
    1, 0, 0;
    0, 1, 0];
B = [1; 0; 0];
C = [0, 0, 1];
D = 0;
sys = ss(A, B, C, D);

% Setting up the initial conditions and control signal for simulation
x0 = [0; 0; 0];
freq = 1/(2*75);
Ts = 0.01;
t0 = 0;
tf = 200;
t = t0:Ts:tf;
u = square(2*pi*freq*t);

% Simulate the system
lsim(sys, u, t);
grid on
saveas(gcf, "square-wave-response.png")
