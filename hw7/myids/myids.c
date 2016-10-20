#include <stdio.h>
#include "myids.h"

int main() {
    int uid, gid; /* Initialize two integer arguments */
    get_ids(&uid, &gid); /* Call get_ids on the integer pointers */
    printf("User ID is %d. Group ID is %d.\n", uid, gid); /* Print Ids */
    return 0;
}
