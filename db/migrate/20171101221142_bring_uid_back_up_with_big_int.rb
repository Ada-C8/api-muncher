class BringUidBackUpWithBigInt < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :bigint, null: false
  end
end
