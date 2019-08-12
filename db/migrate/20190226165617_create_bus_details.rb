class CreateBusDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :bus_details do |t|
			t.integer :route_num
			t.string :name
			t.datetime :arrived_at
			t.integer :board_id
			t.string :route_name
			t.string :bus_number
			t.string :distance
			t.integer :dir

      t.timestamps
    end
  end
end
