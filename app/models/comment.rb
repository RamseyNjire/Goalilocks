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
class Comment < ApplicationRecord
    validates :body, presence: true

    belongs_to :commentable, polymorphic: true

    belongs_to(
        :writer,
        class_name: "User",
        foreign_key: :user_id,
        primary_key: :id
    )
end
