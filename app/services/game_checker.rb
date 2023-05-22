# frozen_string_literal: true

class GameChecker
  def initialize(player)
    @player = player
    @game = player.present? ? player.game : nil
  end

  def current_game
    return unless @game.present?

    kill_player if overtimed?

    @game
  end

  def check_end_game
    end_game if @game.solved?
  end

  private

  def overtimed?
    @game.started? && @player.remaining_time <= 0
  end

  def kill_player
    @player.dead!
    end_game
  end

  def end_game
    @game.ended!
    score = Score.new(player: @player, game: @game)
    score.save!

    high_score = HighScore.find_or_initialize_by(user: @player.user)
    high_score.add_score(score)
    high_score.save!
  end
end
