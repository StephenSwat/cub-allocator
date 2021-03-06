# CUDA CUB cached allocator

The [CUB library](https://nvlabs.github.io/cub/) for CUDA contains a cornucopia
of useful tools for GPGPU programming. However, my experience with the library
is that the documentation is as technical as it is good, and it's hard to get a
quick overview of how things work. This repository serves as documentation for
an exploratory benchmarking effort I performed for the [ACTS
project](https://github.com/acts-project/acts/) to investigate the inner
workings of CUB's cached allocated (the `CachingDeviceAllocator`).

This repository contains a number of source files, sometimes written in both a
standard CUDA style as well as in CUB, that illustrate the use of the cached
allocator and compare its performance to that of traditional CUDA allocation.

## Building

Building the project _should_ be trivially simple. Try the following recipe:

```
mkdir build
cd build
cmake ..
make
```

## Documentation

Each set of executables has some additional documentation to aid in
understanding how they work. The executables are ordered here to provide a
somewhat linear progression in difficulty through the different aspects of using
the allocator. Using `nvprof` to benchmark the different executables is
encouraged!

1. [`minimal`](src/minimal/README.md) is a minimal example of memory allocation.
1. [`noalloc`](src/noalloc/README.md) demonstrates the behaviour of CUB when
   no allocations are performed.
1. [`grind`](src/grind/README.md) shows the benefit of caching when allocating
   and freeing many chunks of memory.
1. [`binsize`](src/binsize/README.md) shows the bin sizing mechanic of the CUB
   allocator.
1. [`freebin`](src/freebin/README.md) shows how bin sizes interact with caching
   mechanisms.