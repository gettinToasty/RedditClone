class Post < ApplicationRecord
  validates :title, :sub_id, :author_id, presence: true

  belongs_to :sub

  has_one :moderator,
    through: :sub,
    source: :moderator

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User
end
