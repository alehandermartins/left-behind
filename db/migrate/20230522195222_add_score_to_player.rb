class AddScoreToPlayer < ActiveRecord::Migration[7.0]
  def change
    remove_column :scores, :user_id
    add_reference :scores, :player, index: true
  end
end
