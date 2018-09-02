class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
			t.string :name
			t.string :reverse_name
			t.float :lat
			t.float :long
			t.integer :direction
			t.integer :sort
			t.string :route_name
			t.integer :route_num

      t.timestamps
    end
  end
end
