# frozen_string_literal: true

class CreateGameActions < ActiveRecord::Migration[7.0]
  def change
    create_table :game_actions do |t|
      t.references :location, index: true
      t.integer :cost, null: false
      t.timestamps
    end
  end
end
