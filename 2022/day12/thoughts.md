# Day 12

## Part 1

This seems to be a maze problem. After looking around for maze solving algorithms, A* seems to be quite suitable here. The key in using it would be determining the heuristic function. Since the maze is practically a three dimensional one, the Manhattan distance seems to be suitable.

We should convert the input from letters to grid position entities, each with information about its height, location, etc.

```rb
Square = Struct(:elevation, :row, :col, keyword_init: true)
```

One consideration is that the input seems to be full of traps:

```txt
abc...cccccccc
abc...ccaaaacc
Sbc...ccaaaacc
abc...ccaaaacc
abc...ccaaaccc
abc...cccccccc
```

We can run the A* algorithm and if it falls into traps it will explore other paths from before it fell in.

## Part 2

This could take a while to calculate _all_ elevations of level `a`. Also, since there are traps, we have to make sure that we're discounting those elevations of level `a` that never made it out of their trap.

We should initialize a cache that short-circuits when encountering a cached level `a` but that doesn't necessarily mean that the path from one to another that's cached is the shortest path.

Maybe we should instead just pick a handful of `a` squares that have the lowest Manhattan distance to the goal square. Well, after looking at the input, the `a`s with the lowest Manhattan distance will likely just be traps near the hill.

Perhaps we should preprocess those `a`s that are traps and disregard them in the initial set that we're looking for. So we need some way to locate `a`s that are grouped together and are bounded by `c`s or higher. I believe this should greatly reduce the number of `a`s that we need to consider and therefore should cut the run time down to waitable amount.

What if we reversed the "start" and "goal"? If the `E` square was the start and any `a` square was the goal, then really we have an uninformed search with traversal rules reversed. Here, BFS sounds like the algorithm to implement. This seems like a much better choice than what was described above.
