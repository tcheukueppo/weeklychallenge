#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

unsigned int fac(unsigned int n);
char **      alloc_perms(char **perms, unsigned int prev_len, unsigned int len);
void         alloc_error(int l);
void         gen_perms(char **perms, char *str, unsigned int start, unsigned int len);
void         sort_perms(char **perms, unsigned int perm_len);
unsigned int dict_rank(char *str, char **perms, unsigned int perm_len);

int
main(void)
{
   int i, data_len = 3, prev_len = 0;

   struct { char *str; unsigned int len; } data[] = {
      { "CAT",    3 },
      { "GOOGLE", 6 },
      { "SECRET", 6 },
   };

   char **perms = NULL;

   for (i = 0; i < data_len; i++) {
      int j;
      unsigned int perm_len = fac(data[i].len);

      for (j = 0; j < prev_len; j++)
         if (*perms[i] != '\0')
            free(perms[j]);

      if (!perms || prev_len < perm_len)
         perms = alloc_perms(perms, prev_len, perm_len);

      gen_perms(perms, data[i].str, 0, data[i].len - 1);
      sort_perms(perms, perm_len);

      fprintf(stdout, "dict rank('%s') = %u\n", data[i].str, dict_rank(data[i].str, perms, perm_len));
      prev_len = perm_len;
   }
   
   for (i = 0; i < prev_len; i++)
      if (!(*perms[i] == '\0'))
         free(perms[i]);
   free(perms);

   return 0;
}

unsigned int
fac(unsigned int n)
{
   unsigned int f = 1;

   assert(n > 0);
   for (; n != 0; n--)
      f *= n;

   return f;
}

char **
alloc_perms(char **perms, unsigned int prev_len, unsigned int len)
{
   char **nperms = realloc(perms, sizeof(char *) * len);

   if (!nperms) {
      free(perms);
      alloc_error(__LINE__);
   } 

   return nperms;
}

void
alloc_error(int l)
{
   fprintf(stderr, "Line: %d, Err: failed to alloc\n", l);
   exit(1);
}

void
gen_perms(char **perms, char *str, unsigned int start, unsigned int len)
{
   static char *dstr;
   static unsigned int p = 0, perm_len;

   if (start == 0) {
      p = 0;
      perm_len = fac(len + 1);
      dstr = strdup(str);
   }

   if (start == len) {
      perms[p++] = strdup(dstr);

      if (perm_len == p)
         free(dstr);
   }
   else {
      char tmp;
      unsigned int i;

      for (i = start; i <= len; i++) {
         tmp = dstr[start];
         dstr[start] = dstr[i];
         dstr[i] = tmp;

         gen_perms(perms, dstr, start + 1, len);
         
         dstr[i] = dstr[start];
         dstr[start] = tmp;
      }
   }

   return;
}

void
sort_perms(char **perms, unsigned int perm_len)
{
   char *tmp;
   unsigned int i, j;

   for (j = 1; j < perm_len; j++) {
      char *insert = perms[j];

      for (i = 0; i < j; i++) {
         int cmp;

         if (*perms[i] == '\0')
            continue;

         cmp = strcmp(insert, perms[i]);
         if (cmp < 0) {
            tmp = insert;
            insert = perms[i];
            perms[i] = tmp;
         }
         else if (cmp == 0) {
            free(perms[i]);
            perms[i] = "";
         }
      }

      perms[j] = insert;
   }
}

unsigned int
dict_rank(char *str, char **perms, unsigned int perm_len)
{
   unsigned int i, nulls = 0;

   for (i = 0; i < perm_len; i++) {
      if (*perms[i] == '\0') {
         nulls++;
         continue;
      }
      if (strcmp(perms[i], str) == 0)
          break;
   }

   assert(i < perm_len);
   return (++i - nulls);
}
