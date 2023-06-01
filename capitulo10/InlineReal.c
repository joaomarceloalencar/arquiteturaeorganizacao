/*
   Building Instructions:
   cl InlineReal.c
*/
  
#include <stdio.h>
int main() {
  double x, y;
  printf("\n%s", "Enter a double for x: ");
  scanf_s("%lf", &x);

  __asm {
	fld x
	fstp y
  }
  
  printf("\n%s%6.4f\n\n", "The double in y is: ", y);
  return 0;
}