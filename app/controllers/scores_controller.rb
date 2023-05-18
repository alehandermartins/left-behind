# frozen_string_literal: true

class ScoresController < ApplicationController

  def index
    @scores = current_user.scores
  end
end
