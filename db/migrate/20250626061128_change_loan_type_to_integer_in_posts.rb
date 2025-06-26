class ChangeLoanTypeToIntegerInPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :loan_type, :string
    add_column :posts, :loan_type, :integer
  end
end
