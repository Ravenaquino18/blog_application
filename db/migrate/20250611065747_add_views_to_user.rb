class AddViewsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :views, :integer
  end
end
