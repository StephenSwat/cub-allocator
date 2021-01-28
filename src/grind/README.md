# `grind`

In this example, we will start seeing the advantage that CUB can bring to the
table in terms of allocation performance. We will allocate one kilobyte of
memory on the device and immediately free it (you might imagine the allocation
and free are interspersed with some computation) one hundred thousand times. In
this somewhat artificial use case, the caching properties of CUB will start to
shine.

In profiling, the performance difference is stark. The CUB implementation
completes the task in roughly two hundred milliseconds, while the standard CUDA
implementation takes about eleven seconds. The `nvprof` output for the CUB
implementation is as follows:

```
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
      API calls:   47.15%  138.60ms         1  138.60ms  138.60ms  138.60ms  cudaMalloc
                   20.45%  60.113ms    200001     300ns     260ns  207.04us  cudaGetDevice
                   19.52%  57.374ms    100000     573ns     510ns  200.44us  cudaEventRecord
                   12.67%  37.253ms    300007     124ns     100ns  236.29us  cudaGetLastError
                    0.07%  218.41us         1  218.41us  218.41us  218.41us  cuDeviceTotalMem
                    0.07%  218.18us       101  2.1600us     240ns  92.034us  cuDeviceGetAttribute
                    0.05%  134.80us         1  134.80us  134.80us  134.80us  cudaFree
```

The standard CUDA approach looks markedly different:

```
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
      API calls:   61.42%  6.63570s    100000  66.356us  54.353us  126.48ms  cudaMalloc
                   38.57%  4.16697s    100000  41.669us  35.467us  667.99us  cudaFree
```

The most noticeable effect is that CUB can re-use a single chunk of memory; when
the order is given to free device memory, the CUB cached allocator does not
actually free the memory on the device. Instead, it returns it to a pool of
available blocks of memory to be used again when the allocation function is
called. This means there is really only a single device allocation in the entire
program, whereas the standard CUDA version performs one hundred thousand
allocations and frees.