class CreateConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :category
      t.integer :point, default: 0

      t.timestamps
    end
  end
end
