# frozen_string_literal: true

class AddReferenceToLocations < ActiveRecord::Migration[7.0]
  def change
    remove_reference :locations, :archetypes
    add_reference :locations, :archetype, index: true
  end
end
