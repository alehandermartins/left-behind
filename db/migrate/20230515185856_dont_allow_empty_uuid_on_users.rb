class DontAllowEmptyUuidOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :uuid, false
  end
end
