# frozen_string_literal: true

class ActionsController < ApplicationController
  before_action :check_game_overtimed, only: [:update]

  def update
    return redirect_to game_path(current_game) if current_game.ended?

    @action = Action.find(params[:id])

    if @action.dependencies?
      fail_action
      kill_user if current_user.suffocated?
    elsif @action.cost <= current_user.oxygen.quantity
      perform_action
      check_game_ended
    else
      end_game
    end
  end

  private

  def fail_action
    @action.failure!
    current_user.oxygen.decrement! :quantity, 1
  end

  def perform_action
    @action.success!
    current_user.oxygen.decrement! :quantity, @action.cost
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

    kill_user if current_user.suffocated?
  end

  def end_game
    @action.failure!
    current_user.oxygen.update!(quantity: 0)
    kill_user
  end
end
