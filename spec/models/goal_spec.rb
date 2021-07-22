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
require 'rails_helper'

RSpec.describe Goal, type: :model do
  subject(:goal){ build(:goal) }
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:is_complete) }
    it { should validate_presence_of(:is_private) }
  end

  describe "associations" do
    it { should belong_to(:creator) }
  end
end
