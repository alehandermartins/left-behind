# frozen_string_literal: true

class AddIndexToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :index, :integer
  end
end
