# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string           not null
#
FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    password { "Password" }
    factory :goal_creator do
      username { "Zeno" }
    end
    factory :comment_writer do
      username { "Cicero" }
    end
    factory :commented_user do
      username { "Constantine" }
    end
  end
end
