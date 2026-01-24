#include <stdio.h>

int main()
{
    int n,sum=0,i,j,pow;
    printf("Enter the term : ");
    scanf("%d",&n);

    printf("\nSeries : ");
    for(i=1; i<=n; i++)
    {
        pow=1;
        for(j=1; j<=i; j++)
        {
            pow*=2;
        }
        printf("%d ",pow);
        sum+=pow;
    }
    printf("\n\nSum = %d\n",sum);


    return 0;
}
