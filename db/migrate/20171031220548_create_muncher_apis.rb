class CreateMuncherApis < ActiveRecord::Migration[5.1]
  def change
    create_table :muncher_apis do |t|

      t.timestamps
    end
  end
end
