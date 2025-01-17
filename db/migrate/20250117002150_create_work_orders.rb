class CreateWorkOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :work_orders do |t|
      t.integer :technician
      t.integer :location
      t.datetime :time
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
