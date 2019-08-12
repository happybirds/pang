class CreatePageSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :page_settings do |t|
			t.integer :page_id
			t.integer :app_setting_id
      t.timestamps
    end
  end
end
