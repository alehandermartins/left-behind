# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :game
  belongs_to :user

  before_save :populate

  def populate
    self.archetype = game.archetype
    self.resource = user.oxygen.quantity
    self.time = 600 - (game.ended_at - game.started_at).to_i

    self.total = calculate_total
  end

  private

  def calculate_total
    return -100 if user.dead?

    self.resource * 100 + self.time
  end
end
