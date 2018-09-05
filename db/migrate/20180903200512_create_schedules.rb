class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
    	t.string :title
      t.string :bgcolor
      t.string :margin
    	t.string :start
    	t.string :end
    	t.string :classroom
    	t.integer :address
    	t.integer :date

      t.timestamps
    end
  end
end
