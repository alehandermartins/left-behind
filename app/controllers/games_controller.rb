# frozen_string_literal: true

class GamesController < ApplicationController
  layout 'game', only: [:show]
  before_action :check_current_game, only: [:show]

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
end
