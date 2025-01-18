class AddWoId < ActiveRecord::Migration[8.0]
  def change
    add_column :work_orders, :order_id, :integer
    add_column :locations, :location_id, :integer
    add_column :technicians, :technician_id, :integer
  end
end
