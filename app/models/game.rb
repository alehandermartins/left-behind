# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :user_games
  has_many :users, through: :user_games
  has_many :locations

  enum :status, %i[created ongoing ended]

  scope :ongoing, -> { where(status: :ongoing) }
end
