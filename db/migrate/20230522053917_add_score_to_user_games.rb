class AddScoreToUserGames < ActiveRecord::Migration[7.0]
  def change
    add_column :user_games, :score, :integer, default: 0
  end
end
