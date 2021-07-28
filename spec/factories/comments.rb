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
