class BringUidUp < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :bigint, null: false, limit: 25
  end
end
