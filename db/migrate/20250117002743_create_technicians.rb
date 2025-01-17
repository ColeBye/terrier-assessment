class CreateTechnicians < ActiveRecord::Migration[8.0]
  def change
    create_table :technicians do |t|
      t.text :name

      t.timestamps
    end
  end
end
