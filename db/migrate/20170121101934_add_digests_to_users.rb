class AddDigestsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :remember_digest, :string
    add_column :users, :activated, :boolean
    add_column :users, :activate_digest, :string
    add_column :users, :password_reset, :boolean
    add_column :users, :password_reset_digest, :string
    add_column :users, :password_reset_sent_at, :datetime
  end
end
