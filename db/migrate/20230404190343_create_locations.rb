# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :archetypes, index: true
      t.timestamps
    end
  end
end
