#!/usr/bin/python3
import matplotlib.pyplot as plt
import numpy as np
import scipy.integrate


def problem_1():
    density = 30
    x1 = np.linspace(-5, 5, num=density)
    x2 = np.linspace(-np.pi, np.pi, num=density)
    (x1_grd, x2_grd) = np.meshgrid(x1, x2)
    u = x2_grd
    v = -np.sin(x1_grd) - x2_grd

    initial_conditions = [
            [0, -3],
            [0, 3],
            [2, -3],
            [-2, 3],
            [1, 0],
            [-1, 0],
            ]
    t = np.linspace(0, 20, num=1000)
    trajectories = []
    for x0 in initial_conditions:
        traj = scipy.integrate.odeint(lambda x, t: [x[1], -np.sin(x[0]) - x[1]], x0, t)
        trajectories.append(traj)

    density_heatmap = 100
    x1_hm = np.linspace(-5, 5, num=density)
    x2_hm = np.linspace(-np.pi, np.pi, num=density)
    (x1_grd_hm, x2_grd_hm) = np.meshgrid(x1_hm, x2_hm)


    V = 1 - np.cos(x1_grd) + 1/2*x2_grd**2
    plt.imshow(V)


    fig = plt.figure(figsize=(12, 6))
    ax = plt.subplot()
    ax.quiver(x1, x2, u, v, color=[.7, .7, .7])
    for idx, traj in enumerate(trajectories):
        ax.plot(traj[:, 0], traj[:,1], ls="--", lw=2, label=f"x0 = {initial_conditions[idx]}", zorder=1)
    ax.set_xlabel("x_1")
    ax.set_ylabel("x_2")
    ax.set_title("Vector field of the system with ss trajectories")
    ax.scatter(0, 0, color='black', label="origin", zorder=2)
    ax.legend(loc='center left', bbox_to_anchor=(0.9, 0.5))
    plt.show()


def system(t, x, A, B):
    alpha = -3
    beta = 5

    def u(t):
        """Inner function explicit decleration for clarity"""
        if t >= 0 and t < 1:
            return alpha
        else:
            return beta


    return A@x + np.reshape(B.T*u(t), (2,))

def problem_2():
    A = np.array([[0, 0], [1, 0]])
    B = np.array([[1], [0]])
    x0 = [0, 2]

    t = np.linspace(0, 2, num=1000)
    sys = lambda x, t: system(t, x, A, B)
    result = scipy.integrate.odeint(sys, x0, t)

    fig, ax = plt.subplots(2, 1)
    ax[0].plot(t, result[:, 0], color="blue", label=r"$x_1$")
    ax[0].grid()
    ax[0].legend()
    ax[1].plot(t, result[:, 1], color="red", label=r"$x_2$")
    ax[1].grid()
    ax[1].legend()
    plt.show()

    density = 30
    x1 = np.linspace(-3, 2, num=density)
    x2 = np.linspace(-0.5, 2, num=density)
    (x1_grd, x2_grd) = np.meshgrid(x1, x2)
    u = np.zeros(shape=np.shape(x1_grd))
    v = x1_grd

    plt.plot(result[:, 0], result[:, 1])
    plt.xlabel(r"$x_1$")
    plt.ylabel(r"$x_2$")
    plt.quiver(x1, x2, u, v, color=[.7, .7, .7])
    plt.scatter([0], [2], label=r"$x_0$", color=[0.8, 0.8, 0.8])
    plt.scatter([2], [0], label=r"$x_f$", color=[0.5, 0.5, 0.5])
    plt.title("State Space Trajectory")
    plt.legend()
    plt.grid()
    plt.show()


if __name__ == "__main__":
    problem_2()
