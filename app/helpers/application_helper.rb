# frozen_string_literal: true

module ApplicationHelper

  def user_loged_in?
    @current_user.email.present?
  end

  def game_available?
    !(GameCreator::ARCHETYPES - @current_user.played_archetypes).empty?
  end

  def current_game
    @current_game
  end

  def current_player
    @current_player
  end

  def remaining_time(score)
    total_seconds = score.time

    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60

    format("%02d:%02d", minutes, seconds)
  end

  def hint
    action = current_game.unresolved_action
    return unless action.present?

    trans("locations.#{action.location.index}.actions.#{action.index}.hints.#{rand(2)}")
  end

  def trans(key)
    t("#{current_game.archetype}." + key)
  end
end
