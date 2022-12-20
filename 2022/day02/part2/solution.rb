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

  attr_reader :opponent, :outcome

  def initialize(input = {})
    @opponent = input.fetch(:opponent)
    @outcome = input.fetch(:outcome)
  end

  def score
    round_score = SCORE_MAP[choice]

    round_score += 6 if win?
    round_score += 3 if tie?
    round_score += 0 if lose?

    round_score
  end

  private

  def win?
    outcome == :win
  end

  def tie?
    outcome == :tie
  end

  def lose?
    outcome == :lose
  end

  def choice
    return opponent if tie?
    return BEAT_MAP[opponent] if lose?
    return BEAT_MAP.invert[opponent] if win?
  end
end

SolutionFile.with __dir__ do |input|
  round_lines = input.split "\n"

  OPPONENT_MAP = {
    'A' => :rock,
    'B' => :paper,
    'C' => :scissors
  }

  OUTCOME_MAP = {
    'X' => :lose,
    'Y' => :tie,
    'Z' => :win
  }

  rounds = round_lines.map { |round_line| round_line.split }.map do |round|
    Round.new(opponent: OPPONENT_MAP[round[0]], outcome: OUTCOME_MAP[round[1]])
  end

  rounds.sum(&:score)
end
