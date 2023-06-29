# import numpy
import numpy as np


# # create function

def swc_loop(x, y, delta, TR):
    h = 2 * delta * TR
    r = np.zeros((len(x)))

    for n in range(delta, (len(x) - delta)):
        a = n - delta
        b = n + delta
        r[n] = (TR / h) * np.sum((x[a:b] * y[a:b]) - (np.mean(x[a:b]) * np.mean(y[a:b])))

    return r, float(h)