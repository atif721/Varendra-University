#include <stdio.h>
#include <string.h>

int main()
{
    int *p;
    int q;

    p = &q;
    printf("%d \n",p);

    p++;
    printf("\n%d \n",p);

    return 0;
}
