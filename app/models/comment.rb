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
