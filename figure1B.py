import numpy as np
import matplotlib.pyplot as plt
from swc_module import swc_loop

Hz = 0.025
nt = 120
w = 2 * np.pi * Hz
k = np.arange(nt)
TR = 1.0
theta = np.arccos(.2); # phase difference

x = np.cos(w * k * TR)
x = x / np.std(x)
y = np.cos(w * k * TR  + theta)
y = y / np.std(y)


r = np.zeros((60, nt))
h = np.zeros((60, 1))

for delta in range(60):
    r[delta, :], h[delta] = swc_loop(x, y, delta+1, TR)

h = np.tile(h, (1, nt))
z = r != 0

plt.scatter(h[z], r[z], marker='.')
plt.hlines(y=0.2, xmin=0, xmax=120, colors='red')
plt.xlabel('h (window length)')
plt.ylabel('covariance')
plt.show()