class AddDependencyToActions < ActiveRecord::Migration[7.0]
  def change
    add_column :actions, :dependencies, :string
  end
end
