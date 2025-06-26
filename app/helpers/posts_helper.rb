module PostsHelper
  def loan_type_label(type)
    # Convert integer enum to string key if needed
    type = Post.loan_types.key(type) if type.is_a?(Integer)

    case type.to_s
    when "student" then "🎓 Student Loan"
    when "personal" then "💳 Personal Loan"
    when "business" then "🏢 Business Loan"
    else type.to_s.titleize
    end
  end
end
