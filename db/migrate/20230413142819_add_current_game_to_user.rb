class AddCurrentGameToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :game, index: true, optional: true
  end
end
