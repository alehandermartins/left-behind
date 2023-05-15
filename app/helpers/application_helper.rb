# frozen_string_literal: true

module ApplicationHelper
  def user_loged_in?
    @current_user.email.present?
  end

  def current_game
    @current_game
  end

  def oxygen
    @current_user.oxygen.quantity
  end

  def hint
    action = current_game.unresolved_action
    return unless action.present?

    t("locations.#{action.location.index}.actions.#{action.index}.hints.#{rand(2)}")
  end
end
