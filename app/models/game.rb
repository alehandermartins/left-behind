# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :players
  has_many :users, through: :players
  has_many :locations
  has_many :actions, through: :locations

  enum :status, %i[created started ended]

  GAME_LENGTH = 180

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

  def remaining_time_for(user)
    time_spent = user_games.where(user: user).penalties * 10
    GAME_LENGTH - (Time.current - self .started_at) - time_spent
  end

  def unresolved_action
    actions.where(necessary: true, status: :undone).sample
  end
end
