# adventofcode

## Initialize a day

Populate a new day with:

```sh
./bin/init.rb --day 1
```

This will create a directory structure in `.` with:

```txt
.
├── 2024
│   ├── day01
│   │   ├── example_input.txt
│   │   ├── parse.rb
│   │   ├── part1
│   │   │   ├── input.txt
│   │   │   ├── problem.md
│   │   │   └── solution.rb
│   │   ├── part2
│   │   │   ├── input.txt
│   │   │   ├── problem.md
│   │   │   └── solution.rb
│   │   └── thoughts.md
...
```

Manually populate the `example_input.txt`, `parse.rb`, `part1/input.txt`, `part1/problem.md`, `part1/solution.rb`, `part2/input.txt`, `part2/problem.md`, `part2/solution.rb`, and `thoughts.md` as needed.

## Run

Check the solution with the example input:

```sh
./bin/run.rb --day 1 --part 1 --jog
```

Run the solution with:

```sh
./bin/run.rb --day 1 --part 1
```

## Logs

After each run, logs will be appended in `log/[year]/day[day]/part[part].log`.

## Precendence

This document serves as documentation for the latest process, be sure to refer each year's `README.md` if applicable. Before changing this `README.md`, copy its current contents into previous years for which it applied.
