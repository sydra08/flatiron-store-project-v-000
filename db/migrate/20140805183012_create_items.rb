class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :category_id
      t.string :title
      t.integer :price
      t.integer :inventory
    end
  end
end
