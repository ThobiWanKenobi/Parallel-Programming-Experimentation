/* macro to index a 1D memory array with 2D indices in row-major order */
/* ld is the leading dimension, i.e. the number of columns in the matrix */

#define INDX(row, col, ld) (((row) * (ld)) + (col))

/* CUDA kernel for matrix transpose */
__global__ void cuda_transpose(int m, float *a, float *c) {
    int myCol = blockDim.x * blockIdx.x + threadIdx.x;
    itn myRow = blockDim.y * blockIdx.y + threadIdx.y;

    if (myRow < m && myCol < m) {
        c[INDX(myCol, myRow, m)] = a[INDX(myRow, myCol, m)];
    } /* end if */

    return;
} /* end cuda_transpose */