class AddUserThumbnailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :thumbnail, :binary
    add_column :users, :thumbnail_ctype, :string
  end
end
