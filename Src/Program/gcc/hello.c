
/**
 * @brief  This is example C code
 *
 * @param argc
 * @param argv
 * @return int
 */
#include <stdio.h>
int func(int n)
{
    int sum = 0, i;
    for (i = 1; i <= 100; i++)

    {
        sum += i;
    }
    return sum;
}

void main()
{
    int i;
    long result = 0;
    for (i = 1; i <= 100; i++)

    result += i;

    printf("result[1-100] = %d", result);
    printf("result[1-250] = %d", func(250));
}
