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

  def score
    @score ||= @current_user.current_score
  end

  def hint
    action = current_game.unresolved_action
    return unless action.present?

    trans("locations.#{action.location.index}.actions.#{action.index}.hints.#{rand(2)}")
  end

  def trans(key)
    t("#{current_game.archetype}." + key)
  end

  def oxygen_score
    return "-" if @current_user.dead?

    "#{oxygen} x 100"
  end

  def time_score
    return "-" if @current_user.dead?

    600 - (current_game.ended_at - current_game.started_at).to_i
  end

  def total_score
    return -100 if @current_user.dead?

    oxygen * 100 + 600 - (current_game.ended_at - current_game.started_at).to_i
  end
end
