# frozen_string_literal: true

class ChangeUsergamesToUserGames < ActiveRecord::Migration[7.0]
  def change
    rename_table :usergames, :user_games
  end
end
