# frozen_string_literal: true

class AddDefaultStatusToGameActions < ActiveRecord::Migration[7.0]
  def change
    change_column :game_actions, :status, :integer, default: 0
  end
end
