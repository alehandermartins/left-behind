# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_games
  has_many :games, through: :user_games
  has_many :items

  def ongoing_game
    games.ongoing.last
  end

  def oxygen
    items.oxygen.where(game: ongoing_game).last
  end
end
