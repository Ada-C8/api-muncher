class CreateLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :labels do |t|
      t.integer :recipe_id
      t.string :label
      t.timestamps
    end
  end
end
