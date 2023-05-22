# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_one :score

  enum :status, %i[alive dead]

  def remaining_time
    Game::GAME_LENGTH - (Time.current - game.started_at).to_i - penalties * 10
  end

  def final_time
    time = Game::GAME_LENGTH - (game.ended_at - game.started_at).to_i - self.penalties * 10
    return 0 if time.negative?

    time
  end

  def add_penalty(amount)
    self.increment! :penalties, amount
  end
end
