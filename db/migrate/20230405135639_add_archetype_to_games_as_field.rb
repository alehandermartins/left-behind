# frozen_string_literal: true

class AddArchetypeToGamesAsField < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :archetype, :string
  end
end
