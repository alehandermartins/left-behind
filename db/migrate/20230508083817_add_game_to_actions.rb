class AddGameToActions < ActiveRecord::Migration[7.0]
  def change
    add_reference :actions, :game, index: true
  end
end
