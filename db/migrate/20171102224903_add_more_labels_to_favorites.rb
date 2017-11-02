class AddMoreLabelsToFavorites < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :label, :string
    add_column :favorites, :image, :string
    add_column :favorites, :source, :string
  end
end
