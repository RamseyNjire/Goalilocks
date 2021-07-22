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
class Goal < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true

    belongs_to(
        :creator,
        class_name: "User",
        foreign_key: :creator_id,
        primary_key: :id
    )

end
