#include <stdio.h>

int main() {
  // declare and initialize variables
  int x = 1;
  int y = 2;
  float pi = 3.14;
  float e = 2.72;
  char a = 'a';
  char b = 'b';

  // declare pointers
  int *int_ptr;
  float *float_ptr;
  char *char_ptr;

  // assign pointers to memory addresses of our variables and print values once
  // assigned
  printf("ints:\n");
  int_ptr = &x;
  printf("x: %d\n", *int_ptr);
  int_ptr = &y;
  printf("y: %d\n", *int_ptr);

  printf("floats:\n");
  float_ptr = &pi;
  printf("pi: %f\n", *float_ptr);
  float_ptr = &e;
  printf("e: %f\n", *float_ptr);

  printf("chars:\n");
  char_ptr = &a;
  printf("a: %c\n", *char_ptr);
  char_ptr = &b;
  printf("b: %c\n", *char_ptr);
}
