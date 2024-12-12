# Day 4

## Part 1

First, we'll find all entries marked with `X`. For each `X`, we'll search its applicable neighbors (more on that to follow), and for each neighboring `M` we find, we'll establish a new viable search route seeded with a search direction. For each route and direction, we'll index to the next entry in the seeded direction looking for the next letter until we find `S` in which case we'll increment an overall count.

Since the word for which we're searching has a fixed, known length, we can omit searching for some neighbors and directions of `X` entries. For example, if there's an `X` entry at grid coordinates [2,2], we can omit looking in the west, northwest, and north directions as the most it could lead to is `XMA` and then hit the grid boundaries.

## Part 2

Since we already have in place the indexes, we can now key off of `A` as that will be what will increment the count; if an `A` has exactly two diagonal neighbors `M` and exactly two diagonal neighbors `S` and the two `M`s (or the two `S`s) are diagonally adjacent to each other with respect to their diagonal position about `A`.

This time, we don't have any boundary considerations. This time rather, we can simply omit the outside ring around the grid as there wouldn't exist an "X" pattern about an `A` that on the outside ring of the grid. All other `A` are viable for searching.
