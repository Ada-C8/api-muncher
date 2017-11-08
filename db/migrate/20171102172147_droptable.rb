class Droptable < ActiveRecord::Migration[5.1]
  def change
    drop_table :recipes
    drop_table :labels
    drop_table :ingredients
  end
end
