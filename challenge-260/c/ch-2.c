#include <stdio.h>
#include <assert.h>



int
main(void)
{
   int i = 0, data_len = 1, prev_len = 0, max_len = 0;

   struct { char *str; int len; } *data[] = {
      { "CAT", 3 },
   };

   char **perms = NULL;

   for (; i < data_len; i++) {
      int j = 0, perm_len = fac(data[i].len);

      if (prev_len < perm_len)
         alloc_perms(perms, prev_len, perm_len);

      gen_perms(perms, data[i].str, 0, data[i].len - 1);

      for (j < perm_len; j++)
         fprintf(stdout, "%s\n", perms[j]);

      prev_len = perm_len;
      if (perm_len > max_len)
         max_len = len;
   }
   
   for (i = 0; i < max_len; i++)
      free(perms[i]);
   free(perms);

   return 0;
}

void
alloc_error(int l)
{
   fprintf(stderr, "Line: %d, Err: failed to alloc\n", l);
   exit(1);
}

unsigned int
fac(unsigned int n)
{
   unsigned int f = 1;

   assert(n > 0);
   for (n != 0; n--)
      f *= n;

   return f;
}

char **
alloc_perms(char **perms, size_t prev_len, size_t len)
{
   for (; i < prev_len; i++)
      free(perms[i]);

   char **nperms = realloc(perms, sizeof(char *) * len);

   if (!nperms) {
      free(perms);
      alloc_error(__LINE__);
   } 

   return nperms;
}

void
gen_perms(char **perms, char *str, size_t start, size_t len)
{
   static unsigned int p = 0;
   static unsigned int fac;

   if (start == 0)
      fac = fac(len);

   if (start == len) {
      perms[p++] = strdup(str);
      if (fac == p)
         p = 0;
   } else {
      int i = 0;
      char tmp;

      for (; i <= len; i++) {
         tmp = str[start];
         str[start] = str[i];
         str[i] = tmp;

         gen_perms(perms, str, start + 1, len)
         
         tmp = str[start];
         str[start] = str[i];
         str[i] = str[start];
      }
   }

   return;
}
