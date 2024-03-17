#!/usr/bin/env sh

is_uniq () {
   IFS=,

   # Count the No of occurrences of each elems.
   keys= values=
   for i in $1 ; do
      i=`printf "$i\n" | tr '-' '_'`

      if eval "test -z \"\$h_$i\"" ; then
         eval "h_$i=1"
         keys=$keys${keys:+,}$i
      else
         eval "h_$i=\$((\$h_$i + 1))"
      fi
   done

   # Get the occurrences in a list.
   l=0
   for i in $keys ; do
      eval "values=\"\$values\${values:+,}\$h_$i\""
      l=$(($l + 1))
   done

   # Check uniqueness on the No of each occ.
   test $l -eq `printf "$values\n" | tr , "\n" | uniq | wc -l`
   return $?
}

if test 3 -eq `
   {
      is_uniq 1,2,2,1,1,3            && printf "ok\n"
      is_uniq 1,2,3                  || printf "ok\n"
      is_uniq -2,0,1,-2,1,1,0,1,-2,9 && printf "ok\n"
   } | wc -l
` ; then
   printf "All tests passed.\n"
fi
