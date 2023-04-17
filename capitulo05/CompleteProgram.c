/*
    Building Instructions:
    cl.exe CompleteProgram.c
*/

#include <stdio.h> 
int main() {
    int x, n, i, ans;
    printf("%s", "Enter x: ");
    scanf("%d", &x);
    printf("%s", "Enter n: ");
    scanf("%d", &n);
    if (x < 0 || n < 0)
        printf("\n%s\n\n", "Error: Negative x and/or y");
    else if (x == 0 && n == 0)
        printf("\n%s\n\n", "Error: Undefined answer");
    else {
        i = 1;
        ans = 1;
        while (i <= n) {
            ans = ans * x;
            i++;
        }
        printf("\n%s%d\n\n", "The answer is: ", ans);
    }
    return 0;
}