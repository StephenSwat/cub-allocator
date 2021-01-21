#include <cub/cub.cuh>

int main() {
    cub::CachingDeviceAllocator allocator;

    void *d;

    allocator.DeviceAllocate(&d, 1024);
    allocator.DeviceFree(d);
}
