/*
    Building Instructions:
    cl.exe InputOutput04.c
*/
#include <stdio.h>

int main() {
    int sum, num, i;
    sum = 0;
    while (1) {
        printf("%s", "Enter an integer or a negative integer to stop: ");
        scanf("%d", &num);
        if (num < 0)
            break;
        sum = sum + num;
    }
    printf("\n%s%d\n\n", "The sum is ", sum);
}