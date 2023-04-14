class AddTimestampsToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :started_at, :timestamp
    add_column :games, :ended_at, :timestamp
  end
end
