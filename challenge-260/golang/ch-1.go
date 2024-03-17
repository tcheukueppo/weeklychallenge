package main

import (
   "fmt"
)

func is_uniq(ints []int) bool {
   oc := map[int]int{}

   /* Count the No of occurrences of each elem. */
   for _, v := range ints {
      if _, ok := oc[v]; ok {
         oc[v] += 1
      } else {
         oc[v] = 1
      }
   }

   values := make([]int, 0, len(ints))
   for _, v := range oc {
      values = append(values, v)
   }

   for i := 0; i < len(values) - 1; i++ {
      for j := i + 1; j < len(values); j++ {
         if values[i] == values[j] {
            return false
         }
      }
   }

   return true
}

func main() {
   data := [][]int{
      {1, 2, 2, 1, 1, 3},
      {1, 2, 3},
      {-2, 0, 1, -2, 1, 1, 0, 1, -2, 9},
   }

   for _, v := range data {
      fmt.Println(is_uniq(v))
   }
}
