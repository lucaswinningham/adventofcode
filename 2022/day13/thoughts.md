# Day 13

## Part 1

Parsing the input should be a breeze with `JSON`. Per the example:

```rb
require 'json'

JSON.parse '[1,[2,[3,[4,[5,6,7]]]],8,9]'
# => [1, [2, [3, [4, [5, 6, 7]]]], 8, 9]
```

We just have to keep track of pairs (denoted by "\n\n") and iterate through them asking if they're in the right order and summing their `index + 1` if so.
