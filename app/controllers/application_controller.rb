# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :identify_or_create_user, :set_current_game

  def identify_or_create_user
    session[:user_id] ||= SecureRandom.uuid
    @current_user = User.find_or_create_by(uuid: session[:user_id])
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(session[:user_id])
  end

  def set_current_game
    @current_game = current_user&.ongoing_game
  end
end
