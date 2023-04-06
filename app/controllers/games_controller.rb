# frozen_string_literal: true

class GamesController < ApplicationController
  layout 'game', only: [:show]

  def index; end

  def create
    game = GameCreator.new(current_user).create

    redirect_to game_path(game)
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'Game could not be creted'
    redirect_to games_path
  end

  def show; end
end
