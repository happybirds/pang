class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
			t.string :title
			t.integer :catalog
			t.string :icon
			t.longtext :content
			t.integer :admin_id
			t.integer :status
			
      t.timestamps
    end
  end
end
