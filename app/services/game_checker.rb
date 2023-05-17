# frozen_string_literal: true

class GameChecker
  def initialize(user)
    @user = user
    @game = user.current_game
  end

  def current_game
    return unless @game.present?

    kill_user if @game.overtimed?

    if @game.ended?
      @user.update!(current_game: nil)
      return
    end

    @game
  end

  def check_end_game
    if @game.solved?
      end_game
      return
    end

    kill_user if @user.suffocated?
  end

  private

  def kill_user
    @user.dead!
    end_game
  end

  def end_game
    @game.ended!
    Score.new(user: @user, game: @game).save!
  end
end
