class AddViewsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :views, :integer, default: 0
  end
end
