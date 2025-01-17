class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.text :name
      t.text :city

      t.timestamps
    end
  end
end
