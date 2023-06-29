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

plt.plot(k, x, label='x')
plt.plot(k, y, label='y')
plt.legend()
plt.xlabel('Time [sec]')
plt.ylabel('cosine amplitude')

plt.show()