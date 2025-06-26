require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid with valid attributes" do
    post = Post.new(
      title: "Sample",
      body: "Content",
      amount: 1000.0,
      borrower_name: "John Doe",
      interest_rate: 5.5,
      term_months: 12,
      start_date: Date.today,
      purpose: "Start a small business"
    )
    expect(post).to be_valid
  end
end

