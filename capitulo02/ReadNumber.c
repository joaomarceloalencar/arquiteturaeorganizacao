/*
    Building Instructions:
    cl.exe ReadNumber.c
*/
#include <stdio.h>

int main()
{
    int number;
    scanf("%d", &number);
    printf("\n%s%d\n\n", "The number is: ", number);
    return 0;
}