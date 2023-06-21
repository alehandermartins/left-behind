# frozen_string_literal: true

class User < ApplicationRecord
  has_many :players
  has_many :games, through: :players
  has_many :scores, through: :players
  has_one :high_score

  belongs_to :current_game, class_name: 'Game', foreign_key: 'game_id', optional: true

  validates :uuid, presence: true

  def player
    players.includes(:game).find_by(game: current_game)
  end

  def played_archetypes
    games.map do |game|
      game.archetype
    end
  end
end
