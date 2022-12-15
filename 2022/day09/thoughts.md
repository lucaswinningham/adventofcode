# Day 9

So the tail will really only ever move when the head in the same step moves more than one space away from it.

When the tail _does_ move to keep up with the head, it will simply take the place of where the head immediately was.

This simplifies things greatly, as we don't have to build a board with a 2D array in order to track the head and tail positions.

Initially, we want to parse our input into a stream so we can consume each step one at a time. I'm not sure if there are any optimizations that could be done with long runs (like `R 10`) at this point but consuming the stream for each step should be performant enough.

We'll have an idea of a `Rope` which will have ideas of single `Head` and a single `Tail`. The head and tail will both know of their current position.

## Part 1

The head need only know of its last position so that we can send the tail to it in the event that we need to move the tail. The tail needs to know of all its positions using a `Set` which will keep the positions unique for us.
