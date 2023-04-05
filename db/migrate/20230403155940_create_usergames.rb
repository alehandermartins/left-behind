# frozen_string_literal: true

class CreateUsergames < ActiveRecord::Migration[7.0]
  def change
    create_table :usergames do |t|
      t.references :game, null: false, foreign_key: { to_table: :games }
      t.references :user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
