# frozen_string_literal: true

class ActionsController < ApplicationController

  def update
    return redirect_to root_path unless current_game

    @action = Action.find(params[:id])

    if @action.dependencies?
      fail_action
    elsif @action.cost <= current_user.oxygen.quantity
      perform_action
    else
      fail_action_last_time
    end

    GameChecker.new(current_user).check_end_game
  end

  private

  def fail_action
    @action.failure!
    current_user.oxygen.decrement! :quantity, 1
  end

  def fail_action_last_time
    @action.failure!
    current_user.oxygen.update!(quantity: 0)
  end

  def perform_action
    @action.success!
    current_user.oxygen.decrement! :quantity, @action.cost
  end
end
