# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  commentable_type :string
#  commentable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint
#
FactoryBot.define do
  factory :comment do
    body { "This is a test comment" }
    association :writer, factory: :comment_writer
    trait :for_goal do
      association :commentable, factory: :goal
    end

    trait :for_user do
      association :commentable, factory: :user
    end
  end
end
