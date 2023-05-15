# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :identify_or_create_user

  def identify_or_create_user
    session[:user_id] ||= SecureRandom.uuid
    @current_user = User.find_or_create_by!(uuid: session[:user_id])
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(session[:user_id])
  end

  def current_game
    @current_game ||= current_user.current_game
  end

  def check_current_game
    return unless current_game

    if current_game.overtimed?
      current_user.dead!
      current_game.ended!
    end

    current_user.update!(current_game: nil) if current_game.ended?
    @current_game = nil
  end
end
