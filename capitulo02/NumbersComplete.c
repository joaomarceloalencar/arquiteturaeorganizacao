/*
    Building Instructions:
    cl.exe NumbersComplete.c
*/
#include <stdio.h>

int main()
{
    int num1, num2;
    printf("\n%s", "Enter an integer for num1: ");
    scanf("%d", &num1);
    num2 = num1;
    printf("\n%s%d\n\n", "The integer in num2 is: ", num2);
    return 0;
}