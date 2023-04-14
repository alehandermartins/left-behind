# frozen_string_literal: true

class AddStatusToUserGames < ActiveRecord::Migration[7.0]
  def change
    add_column :user_games, :status, :integer, default: 0
  end
end
