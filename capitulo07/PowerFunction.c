#include <stdio.h>

int x, n, ans;

void power();

int main() {
    printf("%s", "Enter x: ");
    scanf("%d", &x);
    printf("%s", "Enter n: ");
    scanf("%d", &n);
    power();
    printf("\n%s%d\n\n", "The answer is: ", ans);
    return 0;
}

void power() {
    int i;
    ans = -1;
    if (x < 0 || n < 0)
        printf("\n%s\n","Error: Negative x and/or y");
    else
        if (x == 0 && n == 0)
            printf("\n%s\n", "Error: Undefined answer");
        else {
            i = 1;
            ans = 1;
            while (i <= n) {
                ans = ans * x;
                i++;
            }
        }
}
