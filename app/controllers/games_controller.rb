# frozen_string_literal: true

class GamesController < ApplicationController
  layout 'game', only: [:show]

  def index; end

  def create
    archetype = Archetype.find_by(name: 'starship')

    game = ActiveRecord::Base.transaction do
      game = Game.create!(archetype:, status: :ongoing)
      UserGame.create!(user: current_user, game:)
      Item.create!(game:, user: current_user, name: 'oxygen', quantity: 10)
      game
    end

    redirect_to game_path(game)
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'Game could not be creted'
    redirect_to games_path
  end

  def show
  end
end
