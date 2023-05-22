# frozen_string_literal: true

class ActionsController < ApplicationController

  def update
    return redirect_to root_path unless current_game

    @action = Action.find(params[:id])

    if @action.dependencies?
      fail_action
    elsif @action.cost * 10 <= current_player.remaining_time
      perform_action
    else
      fail_action_last_time
    end

    GameChecker.new(current_player).check_end_game
  end

  private

  def fail_action
    @action.failure!
    current_player.add_penalty(1)
  end

  def fail_action_last_time
    @action.failure!
    current_player.add_penalty(@action.cost)
  end

  def perform_action
    @action.success!
    current_player.add_penalty(@action.cost)
  end
end
