class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.references :game, null: false, foreign_key: { to_table: :games }
      t.references :user, null: false, foreign_key: { to_table: :users }

      t.string :archetype, null: false
      t.integer :resource, null: false
      t.integer :time, null: false
      t.integer :total, null: false

      t.timestamps
    end
  end
end
