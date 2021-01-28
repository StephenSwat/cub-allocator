# `freebin`

This time, we perform some allocations of different sizes. First we allocate a
256 kilobyte bin, then free it, then we allocate a 4 kilobyte bin. Notable, CUB
will not re-use the larger page or split it up; it will only allocate a new,
smaller bin. We then free the 4 kilobyte bin and allocate a 1 kilobyte chunk.
The largest bin to fit such a chunk is 4 kilobyte, so the previous page is
re-used and then freed. Then, we allocate a final 512 page, which will once
again not re-use the 4 kilobyte page but allocate a new 512 byte one.