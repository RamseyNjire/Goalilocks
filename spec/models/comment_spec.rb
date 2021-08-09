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
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it { should validate_presence_of(:body) }
  end

  describe "associations" do
    it { should belong_to(:writer) }
    it { should belong_to(:commentable) }
  end
end
