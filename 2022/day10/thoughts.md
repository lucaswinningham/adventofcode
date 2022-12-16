# Day 10

## Part 1

Really when we ask what the value of the register is _during_ cycle `x`, we can take that to be the same as asking what the value of the register is _after_ cycle `x - 1`. So ultimately, we're asking the question, "What is the value of the register _after_ the last mutation instruction that was _before_ the `nth` cycle?" and since we know that the only mutation instruction that exists is `addx` and that it takes `2` cycles to complete, we can simply tap into the stream at cycle `nth - 2` and note the value of the register at that time.

For example, say we want to know the value of the register _during_ the `20th` cycle and that there exists these two scenarios:

 1. `addx` starting at the `19th` cycle
 2. `addx` starting at the `18th` cycle

For #1, the register's value will remain the same _before_, _during_, and _after_ the `19th` cycle and _before_ and _during_ the `20th` cycle and will only change _after_ the `20th` cycle is done. We can disregard this instruction. This will be the same for other `addx`s or `noop`s exist between the `19th` cycle and the `20th` cycle.

For #2, the register's value will remain the same _before_, _during_, and _after_ the `18th` cycle and _before_ and _during_ the `19th` cycle and will only change _after_ the `19th` cycle is done. This is the latest mutation instruction that we care about when looking backwards.

Since `noop`s do nothing but consume a cycle, we can disregard them when looking backwards.

We can calculate how many total instructions there will be with `num_addx * 2 + num_noop`. With this, we're able to know ahead of time an exhaustive list of target cycles that we care about. So, if that forumla results to `100`, we care about `[20, 60, 100]`. If it results to `61`, we care about `[20, 60]`.

Then, we can iterate through the instruction stream at each `target_cycle - 1` or `target_cycle`, whichever comes first and taking the current register value _before_ the instruction is executed as to be the same as it would be _during_ the `target_cycle`. Alternatively, we maybe also look at the register's value _after_ the instruction at `target_cycle - 2` or `target_cycle - 1`, whichever came first.

After recording the register's value at each target cycle, we can calculate the problem's answer.

## Part 2

Super pleased that we didn't have to build a visualization mechanism in Part 1 because we do now!

Much of this part's problem statement resembles that of controls engineering programming with PLCs and their ideas of instructions at three (main) separate stages of a "scan": `prescan`, `scan`, and `postscan`. In Part 1, although we had to consider upfront the ideas of `prescan` and `postscan`, they didn't actually leak into the solution whatsoever. Here, however, we _do_ need to know about these three separate stages.

We'll still have an input parser, of course, but now we actually have to iterate over each `scan` so that we know how the CRT will draw a pixel during it. The sprite's position is tied to single register's value and there will also be the accumulative state of the "screen"; so there will be two states to track as we iterate over the `scan`s. The idea of a `CPU`, an `Instruction` and a `Screen` come to mind in this way.

On each `CPU` tick (which I'll refer to as a `scan` henceforth), we'll either parse and start the execution of a new instruction, or continue the execution of an ongoing instruction.

Looking over the problem statement, we're able to draw the following conclusions:

 1. During the `prescan` phase, the only action that could happen is the initiation of an instruction.
 2. During the `scan` phase, the only action that happens is the drawing of a single pixel by the CRT.
 3. During the `postscan` phase, there are two actions that would happen subsequentially: finish an ongoing instruction execution and then in turn that could mutate the register value / sprite position.

During instruction initiation, we need to load an instruction somewhere for caching in a single slot. This single slot would know what the instruction is, and at what point it's valid for dumping from the slot. During instruction finalization, we would need to query the slot for whether the instruction needs dumped, dumping the instruction and vacating the slot if so, and mutating the register value if necessary. Lastly, during a `scan`, we simply need to push either a `.` or a `#` onto the `Screen` state depending on the sprite's position (and width) for the same index that is to be added.

## Dependencies

The `CPU`, both as described in the problem and as formulated here, would be at the center and would be closest to the implementation layer. It will have an idea of the `register_value`, which will initialize to `1`, an idea of a single `instruction` that should be an instance of `Instruction`.

The `Instruction` would need to know what type it is -- `addx` or `noop` -- and also at what cycle it's to be initiated, which can be calculated. `Addx` and `Noop` could be subclasses of `Instruction` for sole purpose of telling the `CPU` slot consumer when the currently occupied instruction should be ejected which would be especially useful if there were more than simply two instructions that the `CPU` could process.

The `register_value` should belong to the `CPU` to more closely model the description and real-life conditions.

The `Screen`, however, seems to be more a side effect of all the goings-on of the `CPU` and therefore shouldn't really depend on anything else -- especially as it's really just a singularly dimensioned array that will at the end just be sliced into chunks for printing.
