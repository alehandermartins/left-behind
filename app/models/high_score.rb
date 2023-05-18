# frozen_string_literal: true

class HighScore < ApplicationRecord
  belongs_to :user

  def add_score(score)
    self.total += score.total
    if score.total >= 0
      self.solved += 1
    else
      self.unsolved += 1
    end
  end
end
