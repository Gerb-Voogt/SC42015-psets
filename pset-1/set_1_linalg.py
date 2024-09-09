#!/usr/bin/python3
import numpy as np
import scipy.linalg as splinalg

A1 = 1/3*np.array([[1, 5],[10, -4]])
A2 = 1/2*np.array([[-1, 1, -1],[2, -2, 0],[1, -1, -1]])

l1, v1 = np.linalg.eig(A1)
l2, v2 = np.linalg.eig(A2)

print(l2)
for v in v2:
    print("v =", v)

print(l1)
lambda_11 = l1[0]
lambda_12 = l1[1]

print(A1-lambda_12*np.eye(2))
print(A1-lambda_11*np.eye(2))

# print(f"l1 = {l1}")
# print(f"l2 = {l2}")
# print(f"v1 = {v1}")
# print(f"v2 = {v2}")

J1 = np.diag(l1)
# J2 = np.diag(l2)
print(J1)
print(J1**100)
P = np.array([v1[0], v1[1]])
Pinv = np.linalg.inv(P)

K = P@J1**100@Pinv

# print(J2)
# print(A1**100)
# print(np.exp(A2))
