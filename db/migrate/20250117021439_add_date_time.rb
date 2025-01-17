class AddDateTime < ActiveRecord::Migration[8.0]
  def change
    add_column :work_orders, :date_time, :datetime
    remove_column :work_orders, :time, :datetime
  end
end
