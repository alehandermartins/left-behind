class DropResourceFromScores < ActiveRecord::Migration[7.0]
  def change
    remove_column :scores, :resource
  end
end
