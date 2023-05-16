#include <stdio.h>

const int n = 3;
int queue[3], number, front = 0, rear = 0, count = 0;
char command;

int main() {
    void enqueue();
    void dequeue();
    printf("\n%s", "Enter a command, e, d, or s: ");
    scanf("%s", &command);
    while (command != 's') {
        if (command == 'e') {
            printf("\n%s", "Enter a positive integer: ");
            scanf("%d", &number);
            enqueue();
        } else if (command == 'd') {
            dequeue();
            if (number > 0)
                printf("\n%s%d\n", "The integer is: ", number);
        } else 
            printf("\n$s", "Invalid entry, try again");
        printf("\n%s", "Enter a command, e, d, or s: ");
        scanf("%s", &command);
    }
    printf("\n");
    return 0; 
}

void enqueue() {
    if (count < n) {
        count++;
        queue[rear] = number;
        rear = (rear + 1) % n ;
    } else
        printf("\n%s\n", "Error: Queue is full");
}

void dequeue() {
    if (count > 0) {
        count--;
        number = queue[front];
        front = (front + 1) % n;
    } else {
        printf("\n%s\n", "Error: Queue is empty");
        number = -1;   
    }
 }