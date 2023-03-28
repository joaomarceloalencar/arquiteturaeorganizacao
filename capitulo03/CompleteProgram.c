/*
    Building Instructions:
    cl.exe CompleteProgram.c
*/
#include <stdio.h>
int main()
{
    int volts, ohms, amperes;
    printf("\n%s", "Enter the number of volts: ");
    scanf("%d", &volts);
    printf("\n%s", "Enter the number of ohms: ");
    scanf("%d", &ohms);
    amperes = volts / ohms;
    printf("\n%s%d\n\n", "The number of amperes is: ", amperes);
    return 0;
}