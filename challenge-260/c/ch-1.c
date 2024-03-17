#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define plan(n)         assert(n > 0); unsigned int ___t = 0, ___nt = n
#define done_testing()  (assert(___t == ___nt))

#define is(t, e, h)  ___t++;                                         \
                     (t == e)                                         \
                       ? fprintf(stderr, "%d ok - %s\n", ___t, h)  \
                       : fprintf(stdout, "%d not ok - %s\n", ___t, h)

typedef struct N {
   unsigned char o;
   int x;
} N;

bool is_uniq(N *n, int *ints, unsigned char len);

int
main(void)
{
   N* n = NULL;
   unsigned char i;

   plan(3);

   struct { int d[10]; unsigned char e, s; } data[] = {
      { .d = {1, 2, 2, 1, 1, 3},                .s = 6,  .e = 1, },
      { .d = {1, 2, 3},                         .s = 3,  .e = 0, },
      { .d = {-2, 0, 1, -2, 1, 1, 0, 1, -2, 9}, .s = 10, .e = 1, },
   };
   
   for (i = 0; i < 3; i++) {
      is(is_uniq(n, data[i].d, data[i].s), data[i].e, "Each No occurrences uniq?");
   }

   free(n);
   done_testing();
}

bool
is_uniq(N *n, int *ints, unsigned char len)
{
   if (!(n = realloc(n, len * sizeof(N)))) {
      free(n);
      fprintf(stderr, "Line: %d, Err: failed to (re)alloc `n'.\n", __LINE__);
      exit(1);
   }

   unsigned char i, lim = 0;

   /* Count the No of occur of each elem. */
   for (i = 0; i < len; i++) {
      unsigned char j = 0;

      for (; j < lim; j++) {
         if (n[j].x == ints[i]) {
            n[j].o++;
            goto next;
         }
      }

      n[lim].o = 1;
      n[lim].x = ints[i];
      lim++;
      next:
   }

   /* Check if the No of occur of each elem is unique. */
   for (i = 0; i < lim - 1; i++) {
      unsigned char j = 0;

      for (j = i + 1; j < lim; j++)
         if (n[i].o == n[j].o)
            return false;
   }

   return true;
}
