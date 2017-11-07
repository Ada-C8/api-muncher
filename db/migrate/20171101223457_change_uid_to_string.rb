class ChangeUidToString < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :uid, :string, null: false
  end
end
