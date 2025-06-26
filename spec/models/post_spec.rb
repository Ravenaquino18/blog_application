require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = User.create!(email: "howel@example.com", 
                          password: "123456")

      post = Post.new(borrower_name: "John Doe", 
                      amount: 69000, 
                      interest_rate: 10, 
                      term_months: 12,
                      start_date: Date.today,
                      user: user,
                      loan_type: "personal"
                      )

      expect(post).to be_valid
    end

    it "is invalid without a borrower_name" do
      post = Post.new(
        borrower_name: nil,
        amount: 10000.0,
        interest_rate: 5.0,
        loan_type: "personal"
      )
      expect(post).to_not be_valid
    end 

    it "is invalid with a negative amount" do
      post = Post.new(
        borrower_name: "Jane Doe",
        amount: -5000.0,
        interest_rate: 5.0,
        loan_type: "personal"
      )
      expect(post).to_not be_valid
    end

    it "is invalid with a non-numeric interest_rate" do
      post = Post.new(
        borrower_name: "Jane Doe",
        amount: 5000.0,
        interest_rate: "five",
        loan_type: "personal"
      )
      expect(post).to_not be_valid
    end
  end

  describe "enums" do
    it "defines the correct loan types" do
    expected_types = { "personal" => 0, "business" => 1, "student" => 2 }

    expect(Post.loan_types.keys).to contain_exactly(*expected_types.keys)
    expect(Post.loan_types).to eq(expected_types)
  end
  end
end
