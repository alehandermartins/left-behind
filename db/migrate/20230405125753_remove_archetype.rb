# frozen_string_literal: true

class RemoveArchetype < ActiveRecord::Migration[7.0]
  def change
    remove_reference :games, :archetype
    remove_reference :locations, :archetype
    add_reference :locations, :game, index: true
    drop_table :archetypes
  end
end
