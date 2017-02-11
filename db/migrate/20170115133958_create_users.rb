class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :employee_number
      t.string :division
      t.string :gender
      t.datetime :started_at
      t.datetime :birthday
      t.boolean :employee

      t.timestamps
    end
  end
end
