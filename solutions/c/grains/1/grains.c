#include "grains.h"

// This is a much more efficient way to calculate powers of 2
// by using bitwise left shifting, which is a native processor
// instruction. For a given square index, the number of grains
// is 2^(index-1).
// The problem statement says squares are from 1 to 64.
// If we get an index outside this range, we could
// return 0 or an error. This implementation assumes valid input.
// HACK: Why returning 0 for invalid index?
// 1. Logical Return Value: By returning 0, the function is communicating that
// there are "no grains" on a square that does not exist. This is a simple and
// intuitive way to represent an invalid state without causing a program crash
// or an unpredictable result.
// 2. Simplicity: In many programming situations, especially in C where formal
// exceptions are not used, returning a special value (like 0 or -1) is a
// standard way to signal an error or an invalid condition. It puts the
// responsibility on the caller to check the return value and handle the error
// gracefully.
uint64_t square(uint8_t index) {
  if (index < 1 || index > 64) {
    return 0;
  }
  return 1ULL << (index - 1);
}

// Your original total() function would have had a critical flaw:
// integer overflow. The sum of grains on squares 1-63 is 2^63 - 1.
// When you add 2^63 (the grains on square 64), the result would
// have overflowed a 64-bit unsigned integer and wrapped around to 0.
// A more elegant solution is to use the mathematical formula
// for the sum of a geometric series: sum = 2^N - 1.
// For a 64-square board, the total is 2^64 - 1, which is the
// maximum value for a 64-bit unsigned integer.
uint64_t total(void) {
  return UINT64_MAX; // This is a portable way to get 2^64 - 1
}
