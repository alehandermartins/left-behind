# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :player
  belongs_to :game

  before_save :populate

  def populate
    self.archetype = game.archetype
    self.total = calculate_total
    self.time = player.final_time
  end

  private

  def calculate_total
    return -10 if player.dead?

    player.final_time
  end
end
