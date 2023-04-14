# frozen_string_literal: true

class AddNecessaryToActions < ActiveRecord::Migration[7.0]
  def change
    add_column :actions, :necessary, :boolean, default: false
  end
end
