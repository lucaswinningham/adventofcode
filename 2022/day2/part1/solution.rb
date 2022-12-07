require 'solution_file'

class Round
  BEAT_MAP = {
    rock: :scissors,
    paper: :rock,
    scissors: :paper,
  }

  SCORE_MAP = {
    rock: 1,
    paper: 2,
    scissors: 3,
  }

  attr_reader :opponent, :me

  def initialize(input = {})
    @opponent = input.fetch(:opponent)
    @me = input.fetch(:me)
  end

  def score
    round_score = SCORE_MAP[me]

    round_score += 6 if won?
    round_score += 3 if tie?
    round_score += 0 if lost?

    round_score
  end

  private

  def won?
    BEAT_MAP[me] == opponent
  end

  def tie?
    opponent == me
  end

  def lost?
    BEAT_MAP[opponent] == me
  end
end

SolutionFile.with __dir__ do |input|
  round_lines = input.split "\n"

  OPPONENT_MAP = {
    'A' => :rock,
    'B' => :paper,
    'C' => :scissors
  }

  MY_MAP = {
    'X' => :rock,
    'Y' => :paper,
    'Z' => :scissors
  }

  rounds = round_lines.map { |round_line| round_line.split }.map do |round|
    Round.new(opponent: OPPONENT_MAP[round[0]], me: MY_MAP[round[1]])
  end

  puts rounds.sum(&:score)
end
