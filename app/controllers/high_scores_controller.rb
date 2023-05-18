class HighScoresController < ApplicationController

  def index
    @high_scores = HighScore.includes(:user).order("total DESC").first(10)
  end
end