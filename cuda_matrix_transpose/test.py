import numpy as np
from numba import cuda
import cupy as cp

## Matrix transpose kernel, one thread per matrix element launched with
## 2D thread block on 2D grid to match matrix size
@cuda.jit
def transpose(a, c):
    col = cuda.blockDim.x * cuda.blockIdx.x + cuda.threadIdx.x
    row = cuda.blockDim.y * cuda.blockIdx.y + cuda.threadIdx.y
    c[(col, row)] = a[(row, col)]