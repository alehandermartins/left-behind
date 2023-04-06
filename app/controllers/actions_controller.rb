# frozen_string_literal: true

class ActionsController < ApplicationController
  def update
    @game_action = GameAction.find(params[:id])
    current_user.oxygen.decrement! :quantity, @game_action.cost

    @game_action.done!
  end
end
