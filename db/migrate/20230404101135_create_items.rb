# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :game, null: false, foreign_key: { to_table: :games }
      t.references :user, null: false, foreign_key: { to_table: :games }
      t.string :name
      t.integer :quantity

      t.timestamps
    end
  end
end
