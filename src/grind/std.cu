#include <cuda.h>

int main() {
    void *d;

    for (int i = 0; i < 100000; i++) {
        cudaMalloc(&d, 1024);
        cudaFree(d);
    }
}
