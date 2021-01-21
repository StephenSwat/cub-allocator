# `minimal`

These two files represent a minimum compilable product in which we allocate a
bit of memory (one kilobyte) using both CUB and the standard `cudaMalloc`. At
this point, there is little difference between the two approaches. If anything,
the CUB allocator is more verbose. The performance in both cases is equal,
barring random profiling noise.