class RenameUserGames < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_games, :players
  end
end
