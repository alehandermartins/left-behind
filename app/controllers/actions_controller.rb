# frozen_string_literal: true

class ActionsController < ApplicationController
  def update
    @action = Action.find(params[:id])

    if @action.cost <= current_user.oxygen.quantity
      @action.done!
    end

    current_user.oxygen.decrement! :quantity, @action.cost

    check_game_ended
  end

  private

  def check_game_ended
    if current_user.oxygen.quantity <= 0
      current_game.ended!
    end

    if current_game.actions.where(necessary: true, status: "undone").empty?
      current_game.ended!
    end
  end
end
