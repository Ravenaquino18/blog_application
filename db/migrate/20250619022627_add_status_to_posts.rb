class AddStatusToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :status, :string, default: 'pending' # Added default value
  end
end