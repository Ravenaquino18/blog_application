class AddFieldsAndRepaymentSchedulesToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :birthdate, :date
    add_column :posts, :nationality, :string, limit: 30
    add_column :posts, :valid_id, :string, limit: 30
    add_column :posts, :sss_number, :string, limit: 30
    add_column :posts, :payment_mode, :string, limit: 20
  end
end
