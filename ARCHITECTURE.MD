# Project Architecture

## Overview

This project implements Huffman coding and LZSS compression algorithms on byte streams using the Effekt language.

## How it works
Both Huffman coding and LZSS compress the data in fixed data blocks (for example every 4096 bytes). This ensures that we can compress file of any size, which would not possibly fit as whole in the memory. The specs of the blocks can be found in `huffman.effekt` and `lzss.effekt`.

## Components

### `compress.effekt`

Main entry point for the compression application. It handles command-line arguments and invokes the appropriate compression or decompression functions based on user input.

### `lib.effekt`

This module provides the core functions for file compression and decompression using Huffman and LZSS algorithms. It includes:
- `huffmanCompressFile`
- `huffmanDecompressFile`
- `lzssCompressFile`
- `lzssDecompressFile`

### `utils/`
The utility module provides necessary data structures and helper functions to perform the compression and decompression tasks.

#### `lzss.effekt`

Contains the implementation of the LZSS compression and decompression algorithms on byte streams.

#### `huffman.effekt`

Implementation of the huffman coding compression and decompression on byte streams.

#### `ascii_dictionary.effekt`

Provides implementation for 256-key dictionary.

#### `huffman_tree.effekt`

Implements the Huffman tree, which is essential for Huffman coding. It includes functions for building the tree and encoding/decoding data.

#### `circular_array.effekt`

Implements a circular array data structure, which is used in the LZSS algorithm to maintain a sliding window.

#### `heap.effekt`

Implements heap used by the Huffman coding.

#### `resizable_array.effekt`

Implements resizable array used by the Huffman coding.

#### `stream_io.effekt`

Utility for reading/writing bits or bytes from a byte stream without skipping data.


## Program execution

1. **Input Handling**: The `compress.effekt` module reads command-line arguments to determine the source file, compression method, action (compress/decompress), and output file.
2. **Compression/Decompression**: Based on the method specified, the appropriate function from `lib.effekt` is called.
