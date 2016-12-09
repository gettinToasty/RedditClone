class Post < ApplicationRecord
  validates :title, :author_id, presence: true

  has_one :moderator,
    through: :sub,
    source: :moderator

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs,
    dependent: :destroy

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
    dependent: :destroy
end
