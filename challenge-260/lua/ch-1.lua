#!/usr/bin/env lua


function is_uniq(ints)
   local oc = {}

   for _, v in pairs(ints) do
      if oc[v] == nil then oc[v] = 1; goto continue end
      oc[v] = oc[v] + 1
      ::continue::
   end

   for _k, _v in pairs(oc) do
      for __k, __v in pairs (oc) do
         if __v == _v and __k ~= _k then return 0 end
      end
   end

   return 1
end

print(is_uniq({1, 2, 2, 1, 1, 3}))
print(is_uniq({1, 2, 3}))
print(is_uniq({-2, 0, 1, -2, 1, 1, 0, 1, -2, 9}))
