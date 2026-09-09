__global__ void shiftLeftKernel(float *d_in, float *d_out) {
    const unsigned int tid = threadIdx.x;
    extern __shared__ float s_arr[];

    // Copy to shared memory
    s_arr[tid] = d_in[tid];

    __syncthreads();

    // Perform operation
    float newVal = s_arr[(tid + 1) % blockDim.x];
    __syncthreads();
    s_arr[tid] = newVal;

    // Copy to global memory
    d_out[tid] = s_arr[tid];
}