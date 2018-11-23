class CreateNutritions < ActiveRecord::Migration[5.2]
  def change
    create_table :nutritions do |t|
      t.string :name_en
      t.string :name_zh
      t.string :content
      t.timestamps
    end
  end
end
