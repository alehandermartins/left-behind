# frozen_string_literal: true

class DeleteItemFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :name
    remove_column :items, :quantity
  end
end
