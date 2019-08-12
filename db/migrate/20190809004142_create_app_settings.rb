class CreateAppSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :app_settings do |t|
			t.string :name
      t.timestamps
    end
  end
end
