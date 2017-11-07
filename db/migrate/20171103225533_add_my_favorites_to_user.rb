class AddMyFavoritesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :my_favorites, :string, array: true, default: []
  end
end
