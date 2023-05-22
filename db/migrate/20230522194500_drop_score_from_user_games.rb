class DropScoreFromUserGames < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_games, :score
  end
end
