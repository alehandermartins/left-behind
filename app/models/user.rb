# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_games
  has_many :games, through: :user_games
  has_many :items
  belongs_to :current_game, :class_name => "Game", :foreign_key => "game_id", optional: true

  def oxygen
    items.oxygen.where(game: current_game).last
  end
end
