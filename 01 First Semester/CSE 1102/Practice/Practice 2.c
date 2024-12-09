#include<stdio.h>
int main()
{
    int d,m,y;
    printf("enter the number of days: ");
    scanf("%d",&d);
    y=365;
    m=30;
    printf("%d years, %d months, %d days",(d/y),(d%y)/m,(d%y)%m);
    printf("\n");
    return 0;
}
