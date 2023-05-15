# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :user_games
  has_many :users, through: :user_games
  has_many :locations
  has_many :actions, through: :locations

  enum :status, %i[created started ended]

  GAME_LENGTH = 600

  def solved?
    actions.where(necessary: true, status: 'undone').empty?
  end

  def started!
    self.started_at = Time.current
    super
  end

  def ended!
    max_time = self.started_at + GAME_LENGTH
    time_ended = Time.current >= max_time ? max_time : Time.current

    self.ended_at = time_ended
    super
  end

  def overtimed?
    self.started? && Time.current > self.started_at + GAME_LENGTH
  end

  def unresolved_action
    actions.where(necessary: true, status: :undone).sample
  end
end
