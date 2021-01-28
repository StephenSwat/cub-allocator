#include <cub/cub.cuh>

int main() {
    cub::CachingDeviceAllocator allocator;

    void *d;

    for (int i = 0; i < 100000; i++) {
        allocator.DeviceAllocate(&d, 1024);
        allocator.DeviceFree(d);
    }
}
