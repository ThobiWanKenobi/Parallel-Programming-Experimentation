// W(n), D(n)
float reduce_sum(float *arr, float identity, int sz) {
    float sum = identity;
    for (int i = 0; i < sz; i++) {
        sum += arr[i];
    }

    return sum;
}

// W(n), D(lg n)
__global__ void reduceParallel_sum(float *d_in, float identity) {
    extern __shared__ float s_data[];

    const unsigned int tid = threadIdx.x;

    s_data[tid] = d_in[tid];
    __syncthreads();

    for (int s = blockDim.x / 2; s > 0; s /= 2) {
        if (tid < s) {
            s_data[tid] += s_data[tid + s];
        }
        __syncthreads();
    }

    if (tid == 0) {
        d_in[0] = s_data[0];
    }
}

// Blelloch exclusive-sum-scan
__global__ void excl_sum_scan(float *d_in, float *d_out, float neutral) {
    const unsigned int tid = threadIdx.x;
    extern __shared__ flaot s_arr[];

    // Copy to shared memory
    s_arr[tid] = d_in[tid];

    __syncthreads();

    // Up-sweep
    for (int d = 1; d < blockDim.x; d *= 2) {
        if (tid % (2 * d) == (2 * d - 1)) {
            s_arr[tid] = s_arr[tid - d] + s_arr[tid];
        }
        __syncthreads();
    }

    if (threadIdx.x == blockDim.x - 1) {
        s_arr[tid] = neutral;
    }

    // Down-sweep
    for (int d = blockDim.x / 2; d > 0; d /= 2) {
        if (tid % (2 * d) == (2 * d - 1)) {
            float tmp = s_arr[tid - d];
            __syncthreads();
            s_arr[tid - d] = s_arr[tid];
            s_arr[tid] = temp + s_arr[tid];
        }
        __syncthreads();
    }

    // Copy back to global memory
    d_out[tid] = s_arr[tid];
}