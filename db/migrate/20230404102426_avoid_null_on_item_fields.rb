# frozen_string_literal: true

class AvoidNullOnItemFields < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :name, :string, options: { null: false, index: true }
    change_column :items, :quantity, :integer, options: { null: false }
  end
end
