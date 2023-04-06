# frozen_string_literal: true

class AddindexToGameActions < ActiveRecord::Migration[7.0]
  def change
    add_column :game_actions, :index, :integer
  end
end
