# frozen_string_literal: true

class ActionsController < ApplicationController
  def update
    @action = Action.find(params[:id])

    if @action.cost <= current_user.oxygen.quantity
      perform_action
    else
      current_user.oxygen.update!(quantity: 0)
      kill_user
    end
  end

  private

  def perform_action
    @action.done!
    current_user.oxygen.decrement! :quantity, @action.cost

    check_game_ended
  end

  def kill_user
    current_user.dead!
    current_game.ended!
  end

  def check_game_ended
    if current_game.solved?
      current_game.ended!
      return
    end

    kill_user if current_user.oxygen.quantity == 0
  end
end
