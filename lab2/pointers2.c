#include <stdio.h>

int main() {
  // declare and initialize variables
  int a = 22;
  int b = 17;
  int c = 6;
  int d = 4;
  int e = 9;
  int result;

  // declare pointers
  int *a_ptr = &a;
  int *b_ptr = &b;
  int *c_ptr = &c;
  int *d_ptr = &d;
  int *e_ptr = &e;

  // compute result and output
  result = ((*a_ptr = *b_ptr) * (*c_ptr + *d_ptr)) / *e_ptr;
  printf("result = %d\n", result);
}
