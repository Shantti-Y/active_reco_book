class AddPublishToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :published, :boolean, default: true
  end
end
