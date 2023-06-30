import numpy as np
import matplotlib.pyplot as plt


Hz = 0.025
nt = 120
w = 2 * np.pi * Hz
k = np.arange(nt)
TR = 1.0
r = np.zeros((60, nt))
h = np.zeros((60, 1))
r1 = r[24, :]
z = r1 != 0
G = [None] * np.count_nonzero(z)

for g in range(np.count_nonzero(z)):
    G[g] = np.convolve(r1[z], np.ones(g+1) / (g+1), mode='valid')

nc = [len(g) for g in G]
g = np.repeat(np.arange(1, np.count_nonzero(z)+1), nc)

# TO DO: - Figure out why np.concatenate works in jupyter and not plain python file

GG = np.concatenate(G) # ERROR OCCURING HERE


plt.scatter(g, GG, s=1, marker='.')
plt.xlim((0, 120))
plt.ylim((-0.1, 0.4))
plt.hlines(y=0.2, xmin=0, xmax=120, colors='red')
plt.xlabel("g (averaging length)")
plt.ylabel("covariance")
plt.show()