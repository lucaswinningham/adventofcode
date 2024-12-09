# Day 3

This seems to lean heavily into string parsing. Luckily, I enjoy regular expressions and Ruby has great tools available to extract capture groups, even with names!

## Part 1

We'll first scan the input for anything like `mul\(\d{1,3},\d{1,3}\)` then scan each capture to get the multiplier and multiplicand.

## Part 2

