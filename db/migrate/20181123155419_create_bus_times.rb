class CreateBusTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :bus_times do |t|
	  t.integer :board_id
	  t.integer :hour
	  t.integer :minute
	  t.string :ampm
	  t.integer :flag
      t.timestamps
    end
  end
end
