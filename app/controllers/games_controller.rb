# frozen_string_literal: true

class GamesController < ApplicationController
  layout 'game', only: [:show]
  before_action :check_current_game, only: [:index]

  def index; end

  def create
    game = GameCreator.new(current_user).create

    redirect_to game_path(game)
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'Game could not be creted'
    redirect_to games_path
  end

  def show
    return redirect_to(root_path) unless current_game
  end

  def update
    current_game.started!
  end

  private

  def check_current_game
    return unless current_game

    current_user.update!(current_game: nil) if current_game.ended?
  end
end
