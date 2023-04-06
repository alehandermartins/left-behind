# frozen_string_literal: true

class AddStatusToGameActions < ActiveRecord::Migration[7.0]
  def change
    add_column :game_actions, :status, :integer
  end
end
