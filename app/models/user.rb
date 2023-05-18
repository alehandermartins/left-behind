# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_games
  has_many :games, through: :user_games
  has_many :items
  has_many :scores
  has_one :high_score

  belongs_to :current_game, class_name: 'Game', foreign_key: 'game_id', optional: true

  validates :uuid, presence: true

  def oxygen
    items.oxygen.where(game: current_game).last
  end

  def alive?
    user_games.find_by(game: current_game).alive?
  end

  def dead?
    user_games.find_by(game: current_game).dead?
  end

  def dead!
    user_games.find_by(game: current_game).dead!
  end

  def suffocated?
    oxygen.quantity == 0
  end

  def current_score
    scores.find_by(game: current_game)
  end
end
