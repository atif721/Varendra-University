#include<stdio.h>

int main ()
{
    int a,b,c,total;
    printf("enter the numbers:");

     //taking values
    scanf("%d %d %d", &a, &b, &c);

    total= a+b+c;

    printf("The summation is: %d+ %d + %d= %d",a, b , c ,total);

}
