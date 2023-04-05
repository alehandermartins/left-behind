# frozen_string_literal: true

class AddArchetypeToGames < ActiveRecord::Migration[7.0]
  def change
    add_reference :games, :archetype, foreign_key: true
  end
end
