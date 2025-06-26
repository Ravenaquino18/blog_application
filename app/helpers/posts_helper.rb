# app/helpers/posts_helper.rb

module PostsHelper
  def loan_type_label(type)
    case type.to_s
    when "student" then "🎓 Student Loan"
    when "personal" then "💳 Personal Loan"
    when "business" then "🏢 Business Loan"
    else type.to_s.titleize
    end
  end
end
