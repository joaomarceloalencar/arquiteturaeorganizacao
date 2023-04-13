/*
    Building Instructions:
    cl.exe InputOutput03.c
*/
#include <stdio.h>

int main() {
    int sum, num, i;
    sum = 0;
    printf("%s", "Enter an integer or a negative integer to stop: ");
    scanf("%d", &num);
    while (num > 0) {
        sum = sum + num;
        printf("%s", "Enter an integer or a negative integer to stop: ");
        scanf("%d", &num);
    }
    printf("\n%s%d\n\n", "The sum is ", sum);
}