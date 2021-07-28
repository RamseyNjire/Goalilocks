FactoryBot.define do
  factory :comment do
    writer { create(user) }
    body { "This is a test comment" }
    trait :for_goal do
      association :commentable, factory: :goal
    end

    trait :for_user do
      association :commentable, factory: :user
    end
  end
end
