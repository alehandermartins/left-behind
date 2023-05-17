# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :identify_or_create_user
  before_action :check_current_game

  def identify_or_create_user
    session[:user_id] ||= SecureRandom.uuid
    @current_user = User.find_or_create_by!(uuid: session[:user_id])
  end

  def check_current_game
    @current_game = GameChecker.new(@current_user).current_game
  end

  def current_user
    @current_user
  end

  def current_game
    @current_game
  end
end
