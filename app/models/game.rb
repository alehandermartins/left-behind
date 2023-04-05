# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :archetype

  has_many :user_games
  has_many :users, through: :user_games
  has_many :locations, through: :archetype

  enum :status, %i[created ongoing ended]

  scope :ongoing, -> { where(status: :ongoing) }
end
