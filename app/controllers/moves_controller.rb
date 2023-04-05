# frozen_string_literal: true

class MovesController < ApplicationController
  def create
    current_user.oxygen.decrement! :quantity, 1
  end
end
