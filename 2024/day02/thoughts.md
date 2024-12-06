# Day 2

We'll process line-by-line or record-by-record. We can create a simple record `Struct` that can ingest the line (AKA levels) and can itself determine if the record is "safe". This can be done by doing a quick test of the first two numbers in the record to determine which direction the numbers should be heading; increasing or decreasing.

## Part 1

We can iterate trying to find the first occurrence where the difference between two levels is less than 1 or greater than 3. If we can't find any such occurrence, then the record is safe.

## Part 2

We can go through every record marking it with flag that it needs to be reevaluated by removing a certain index, then we can grab those that need another evaluation, remove the element at that index, and perform another evaluation. We can then sum those that passed after another evaluation with those that passed the first time and that should be our answer.

Update: I've been struggling way too much with this problem trying to splice arrays at unsafe occurences. I'm going the "brute force" route where each record will be broken into 1 + (record length) record where the other records are the original record but with one level removed. We're then going to check if any of those splayed out records are safe in order to determine the underlying record's safety. Performance-wise, the max length of any record in the input is `8` so at worst we're checking `9` times more records than part 1 which isn't concerning.

Final update: That turned out well, giving the answer. Phew, spent way too long on this.
