# `noalloc`

This bit of code is perhaps even more boring than the last, but it serves to
show how the CUB allocator is different from an arena allocator. Indeed, an
arena allocator would allocate a large chunk of memory in one go (probably at
initialization time) and allocate memory from there. This is not the case with
the CUB allocator, which takes a lazier approach to allocation. If the allocator
is created and not used, no CUDA allocations are performed on the device. This
can be confirmed via `nvprof`, which simply reports that no profiling data was
collected.