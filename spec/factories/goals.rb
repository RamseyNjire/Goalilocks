# == Schema Information
#
# Table name: goals
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text
#  is_complete :boolean          default(FALSE), not null
#  is_private  :boolean          default(FALSE), not null
#  creator_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :goal do
    title { "New Goal" }
    description { "This is a new goal" }
    is_complete { false }
    is_private { false }
    creator { create(:goal_creator) }
  end
end
