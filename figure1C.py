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
r1 = r[24, :]
z = r1 != 0
G = [None] * np.count_nonzero(z, axis=0)

for g in range(np.count_nonzero(z, axis=0)):
    G[g] = np.convolve(r1[z], np.ones(g+1) / (g+1), mode='valid')

nc = [len(g) for g in G]
g = np.repeat(np.arange(1, np.count_nonzero(z, axis=0)+1), nc)

plt.scatter(g, np.concatenate(G), s=1, marker='.')
plt.xlim((0, 120))
plt.ylim((-0.1, 0.4))
plt.hlines(y=0.2, xmin=0, xmax=120, colors='red')
plt.xlabel("g (averaging length)")
plt.ylabel("covariance")
plt.show()