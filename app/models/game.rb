# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :user_games
  has_many :users, through: :user_games
  has_many :locations
  has_many :actions, through: :locations

  enum :status, %i[created started ended]

  def solved?
    actions.where(necessary: true, status: 'undone').empty?
  end

  def started!
    self.started_at = Time.now
    super
  end

  def ended!
    self.ended_at = Time.now
    super
  end
end
