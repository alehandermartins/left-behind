# frozen_string_literal: true

class ActionsController < ApplicationController
  def update
    @action = Action.find(params[:id])
    current_user.oxygen.decrement! :quantity, @action.cost

    @action.done!
  end
end
