# `binsize`

The CUB allocator uses a concept of bins, and bins have different sizes. For
those familiar with operating system pages, this is somewhat akin to _huge
pages_ on Linux: some pages are larger than others. A CUB allocator is
parameterized with three values that determine the bin sizes:

```cpp
cub::CachingDeviceAllocator allocator(8, 3, 7);
```

In this example, the first parameter is the bin growth factor _g_, the second
parameter is the minimum size _n_, and the second parameter is the maximum size
_m_. The bin sizes available to a cuda allocator are _g_<sup>n</sup>,
_g_<sup>n+1</sup>, ..., _g_<sup>m-1</sup>, _g_<sup>m</sup>. In the above
example, that means the bin sizes are 512 bytes, 4096 bytes (4 kilobytes), 32768
bytes (32 kilobytes), 262144 bytes (256 kilobytes), and 2097152 bytes (2
megabytes).

As another example, the set of parameters _g_ = 16, _n_ = 4, _m_ = 7 would
generate pages of sizes 65536 bytes (64 kilobytes), 1048576 bytes (1 megabyte),
16777216 bytes (16 megabytes), and 268435456 bytes (256 megabytes).

Pay special attention to `stderr` when running this program, as we configure the
allocator to run in debugging mode. That means it will print to the error stream
when it allocates and frees data. Keeping in mind the bin sizes in the first
example listed above, the output should make sense. The allocation of 512 bytes
return a page of 512 bytes, but the allocation of 1024 bytes returns an
allocation equal to the first bin that could fit it, which in this case is 4096
bytes.