# adventofcode

## Initialize a day

Populate a new day with:

```sh
./bin/init.rb --day 1
```

This will create a directory structure in `.` with:

```txt
.
├─── 2023
│   └── day01
│       ├── example_input.txt
│       ├── input.rb
│       ├── input.txt
│       ├── thoughts.md
│       ├── part1
│       │   ├── problem.txt
│       │   └── solution.rb
│       └── part2
│           ├── problem.txt
│           └── solution.rb
...
```

`thoughts.md` will be prepopulate with:

```md
# Day [day]

## Part 1

## Part 2

```

`input.rb` will be prepopulated with:

```rb
module Input
  class << self
    def parse(input)

    end
  end
end

```

`solution.rb`s will be prepopulated with:

```rb

```

Then manually populate the `input.txt`, `example_input.txt`, `thoughts.md` and `problem.txt`s as needed.

## Run

Run a solution with:

```sh
./bin/run.rb --day 1 --part 1
```

Run with the example input instead:

```sh
./bin/jog.rb --day 1 --part 1
```

## Precendence

This document serves as the latest process, be sure to refer each year's `README.md` if applicable.
