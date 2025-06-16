class AddViewsToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :views, :integer
  end
end
