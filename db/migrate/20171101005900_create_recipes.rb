class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :image_url
      t.string :creator
       
      t.timestamps
    end
  end
end
