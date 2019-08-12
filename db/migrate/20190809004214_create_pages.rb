class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
			t.string :name
			t.longtext :content
			t.integer :parent_id
      t.timestamps
    end
  end
end
