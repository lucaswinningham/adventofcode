# Day 1

I'm sure there's a clever way to sort two arrays of numbers while keep track of the index and producing an extra array of differences between the two arrays while in an iteration. We're going to go for development speed here though and instead, we're going to lean on our chosen language, Ruby to help us to get to the answer as simply as possible.

## Part 1

The "easy" path looks like ingesting the input, producing n arrays by the columns of the input, use Ruby's `sort` method on each array individually, `zip` them, `sum` the absolute differences.

## Part 2

Here we can lean on Ruby's `tally` method for arrays to count the occurrences of entries in each list. We can note that we only have to tally entries in the right list if the entry exists in the left list. So, after tallying the input lists:

```rb
{3=>3, 4=>1, 2=>1, 1=>1}
{4=>1, 3=>3, 5=>1, 9=>1}
```

Now we can iterate over the entries in the hash produced from tallying the first list, accessing the values in the second hash produced from tallying the second list with the key from the entry, multiply the values (0 as default value for second list) and further multiply by the entry key, and then sum the result.
