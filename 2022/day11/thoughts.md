# Day 11

## Part 1

If there's a way to calculate the answer through calculations rather than simulations, it's above this engineer's head.

The hardest part here might simply be parsing the input. The good news is that each monkey input is separated by two new lines so splitting the input file by that should give each monkey's configuration which will look like:

### Parsing

```txt
Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0
```

#### Id

We can parse the monkey's `id` using the first line:

```rb
lines.first.match(/Monkey (?<id>\d+):/).named_captures['id'].to_i
```

#### Items

We can parse the starting items by

```rb
# "  Starting items: 54, 65, 75, 74"
lines[1].gsub('  Starting items: ', '').split(', ').map(&:to_i)
```

#### Operation

The operation line appears to always be only a two-sided operation with operators of just additions `+` and multiplications `*` and referencing the `old` value at least once (sometimes twice!). This will be a little tedious to parse with many conditional branches (unless we can find something clever in our language). Parsing it might look something like:

```rb
# "  Operation: new = old + 6"
OPERATOR_MAP = {
  '+' => Add,
  '*' => Multiply
}

left, operator, right = lines[2].gsub('  Operation: new = ', '').split

# Here, we'll convert number strings to numbers if the string isn't the literal 'old',
#   in which case, we'll defer the evaluation to `#call` time's input value
operation = OPERATOR_MAP[operator].new(left: left, right: right)

# operation.call value
```

It might be easiest to convert the `left` and `right` inputs given at initialization to callables that could expect but have the option to ignore the given `#call` `value`.

```rb
class Operator
  def initialize(options = {})
    @left = options.fetch(:left)
    @right = options.fetch(:right)
  end

  def call(value)
    raise NotImplementedError
  end

  private

  attr_reader :left, :right

  def left_callable
    @left_callable = if left == 'old'
                       @left_callable = proc { |value| value }
                     else
                       @left_callable = proc { left.to_i }
                     end
  end

  def right_callable
    @right_callable = if right == 'old'
                        @right_callable = proc { |value| value }
                      else
                        @right_callable = proc { right.to_i }
                      end
  end

  class Add < Operator
    def call(value)
      left_callable.call(value) + right_callable.call(value)
    end
  end
end
```

#### Test

The test line appears to always be a modulo definition. Parsing it might look something like:

```rb
# "  Test: divisible by 19"
lines[3].gsub('  Test: divisible by ', '').to_i
```

##### True / False

Similarly to above we can parse which monkey receives the item on each determination:

```rb
# "    If true: throw to monkey 2"
# "    If false: throw to monkey 0"
lines[4].gsub('    If true: throw to monkey ', '').to_i
lines[5].gsub('    If false: throw to monkey ', '').to_i
```

It appears that the `true` line will always be before the `false` line.

## Part 2

I understand that we have to keep the numbers low because of the iterations and no division happening on each worry level but I have no idea how. I'm certainly no mathematician so I have up because I had no idea and cheated and got some spoilers off [reddit](https://www.reddit.com/r/adventofcode/comments/zih7gf/2022_day_11_part_2_what_does_it_mean_find_another/) and [youtube](https://www.youtube.com/watch?v=-cdn3QkR224&ab_channel=BradleySward)

Yay for the internet!
