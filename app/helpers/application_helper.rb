# frozen_string_literal: true

module ApplicationHelper

  def current_game
    @current_user.current_game
  end

  def oxygen
    @current_user.oxygen.quantity >= 0 ? @current_user.oxygen.quantity : 0
  end
end
