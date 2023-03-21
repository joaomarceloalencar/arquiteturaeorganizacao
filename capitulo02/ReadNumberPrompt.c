/*
    Building Instructions:
    cl.exe ReadNumberPrompt.c
*/
#include <stdio.h>

int main()
{
    int number;
    printf("\n%s","Enter an integer: ");
    scanf("%d", &number);
    printf("\n%s%d\n\n", "The number is: ", number);
    return 0;
}