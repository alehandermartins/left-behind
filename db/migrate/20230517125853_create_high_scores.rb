class CreateHighScores < ActiveRecord::Migration[7.0]
  def change
    create_table :high_scores do |t|
      t.references :user, null: false, index: true, foreign_key: { to_table: :users }
      t.integer :total, null: false, default: 0
      t.integer :solved, null: false, default: 0
      t.integer :unsolved, null: false, default: 0

      t.timestamps
    end
  end
end
