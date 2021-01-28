#include <cub/cub.cuh>

int main() {
    cub::CachingDeviceAllocator allocator(8, 4, 4, 1073741824, false, true);

    void *d;

    allocator.DeviceAllocate(&d, 8192);
    allocator.DeviceFree(d);

    allocator.DeviceAllocate(&d, 8192);
    allocator.DeviceFree(d);
}
