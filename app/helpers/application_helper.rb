# frozen_string_literal: true

module ApplicationHelper

  def user_loged_in?
    @current_user.email.present?
  end

  def current_game
    @current_game
  end

  def current_player
    @current_player
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
