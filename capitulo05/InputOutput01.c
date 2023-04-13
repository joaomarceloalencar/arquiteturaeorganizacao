/*
    Building Instructions:
    cl.exe InputOutput01.c
*/
#include <stdio.h>

int main() {
    int sum, i;
    sum = 0;
    for (i = 0; i <= 10; i++){
        printf("%s", "Enter an integer: ");
        scanf("%d", &sum);
        sum = sum + sum;
    }
    printf("\n%s%d\n\n", "The sum is ", sum);
    return 0;
}