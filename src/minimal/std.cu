#include <cuda.h>

int main() {
    void *d;

    cudaMalloc(&d, 1024);
    cudaFree(d);
}
