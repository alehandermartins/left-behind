class AddInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext'
    add_column :users, :email, :citext
    add_column :users, :name, :string
  end
end
