class AddRecentSearch < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :recent_search, :string, array: true, default: []
  end
end
