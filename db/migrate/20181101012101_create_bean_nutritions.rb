class CreateBeanNutritions < ActiveRecord::Migration[5.2]
  def change
    create_table :bean_nutritions do |t|
      t.integer :bean_id
      t.integer :nutrition_id
      t.string :amount
      t.timestamps
    end
  end
end
