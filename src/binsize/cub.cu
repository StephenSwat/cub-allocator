#include <cub/cub.cuh>

int main() {
    cub::CachingDeviceAllocator allocator(8, 3, 7, 1073741824, false, true);

    void *d;

    allocator.DeviceAllocate(&d, 512);
    allocator.DeviceAllocate(&d, 1024);
    allocator.DeviceAllocate(&d, 1024);
    allocator.DeviceAllocate(&d, 4096);
    allocator.DeviceAllocate(&d, 262144);
    allocator.DeviceAllocate(&d, 524288);
}
