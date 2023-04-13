# frozen_string_literal: true

class LocationsController < ApplicationController
  def index
    @locations = current_game.locations
  end

  def show
    @location = Location.find(params[:id])
  end
end
