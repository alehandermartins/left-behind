class DropUsersDefaultUuid < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:users, :uuid, nil)
    add_index :users, :email
  end
end
