# frozen_string_literal: true

class AddItemFields < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :name, :string, options: { null: false, index: true }
    add_column :items, :quantity, :integer, options: { null: false, index: true }
  end
end
