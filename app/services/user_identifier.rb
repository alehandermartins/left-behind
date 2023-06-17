# frozen_string_literal: true

class UserIdentifier
  def initialize(current_user)
    @current_user = current_user
  end

  def identify(user_params)
    user = User.find_by(email: user_params["email"])
    if user.present?
      ActiveRecord::Base.transaction do
        user.update(uuid: @current_user.uuid, name: user_params["name"])
        Player.where(user_id: @current_user.id).update_all(user_id: user.id)
        merge_high_scores(user)
        @current_user.destroy!
      end
    else
      @current_user.update(email: user_params["email"], name: user_params["name"])
    end
  end

  private

  def merge_high_scores(user)
    high_scores = HighScore.where(user_id: [@current_user.id, user.id])
    HighScore.new(user: user, total: high_scores.sum(&:total), solved: high_scores.sum(&:solved), unsolved: high_scores.sum(&:unsolved)).save!
    high_scores.destroy_all
  end
end
