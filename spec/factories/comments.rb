FactoryBot.define do
  factory :comment do
    trait :for_goal do
      association :commentable, factory: :goal
    end

    trait :for_user do
      association :commentable, factory: :user
    end
  end
end
