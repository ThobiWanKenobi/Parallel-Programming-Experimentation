from numba import cuda
import cupy as cp
import numpy as np

## Defines a CUDA Kernel to perform C = A + B vector addition
@cuda.jit
def vecadd(A, B, C):
    work_index = cuda.grid(1)
    # Using cuPy ndarrays has implicit bounds checking
    C[work_index] = A[work_index] + B[work_index]


try:
    # note that vector size is not a power of 2 nor a multiple of the block_size defined below
    vector_size = 2**24 + 11

    device = cp.cuda.Device()
    ## Create device arrays of uniform random float32 values as input, and an array of zeros
    ## as the result vector
    a = cp.random.uniform(-1, 1, vector_size)
    b = cp.random.uniform(-1, 1, vector_size)
    c = cp.zeros_like(a)

    block_size = 256
    grid_size = int(np.ceil(vector_size/block_size))
    vecadd[grid_size, block_size](a, b, c)

    ## synchronize the CPU thread and the GPU to ensure that the kernel has completed
    ## this is included to illustrate good practices, even though the copy below would implicitly wait for
    ## the kernel to complete
    device.synchronize()

    ## Copy all 3 arrays to the CPU as ndarrays
    a_np = cp.asnumpy(a)
    b_np = cp.asnumpy(b)
    c_np = cp.asnumpy(c)

    ## Perform the copy on the CPU to verify the answer
    expected = a_np + b_np

    ## Test that the answer is correct, within floating point epsilon
    np.testing.assert_array_almost_equal(c_np, expected)

    ## The assert will print diagnostics and abort
    ## so this only prints if the assertion passes
    print("Test succeeded")
except Exception as e:
    print(f"Exception occurred: {e}")