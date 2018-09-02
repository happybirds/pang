class CreateBuses < ActiveRecord::Migration[5.2]
  def change
    create_table :buses do |t|
			t.string :bus_number
			t.string :route_number
			t.float :lat
			t.float :long
			t.float :cell_strength
			t.float :speed
			t.datetime :update_time
			t.float :max_bump
			t.float :avg_bump
			t.float :bump_samples
			t.float :accuracy
			t.float :battery

      t.timestamps
    end
  end
end
