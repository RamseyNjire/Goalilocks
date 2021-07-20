# == Schema Information
#
# Table name: goals
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text             not null
#  completed   :boolean          default(FALSE), not null
#  privacy     :boolean          default(FALSE), not null
#  creator_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :goal do
    title { "New Goal" }
    description { "This is a new goal" }
  end
end
