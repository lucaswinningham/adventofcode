# adventofcode

## Initialize a day

Populate a new day with:

```sh
# ruby bin/init.rb . 2023 1
ruby bin/init.rb . [year] [day]
```

This will create a directory structure in `.` with:

```txt
.
├─── [year]
│   └── day[day]
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
# ruby -I . [year]/[day]/[part]/solution.rb
# ruby -I . -I ./other [year]/[day]/[part]/solution.rb
# ruby -I . bin/run.rb 2023 1 2
ruby -I . bin/run.rb [year] [day] [part]
```

Run with the example input instead:

```sh
# ruby -I . bin/jog.rb 2023 1 2
ruby -I . bin/jog.rb [year] [day] [part]
```
