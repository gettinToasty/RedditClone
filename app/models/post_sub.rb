class PostSub < ApplicationRecord
  validates :sub, :post, presence: true
  validates :post_id, uniqueness: { scope: :sub_id }

  belongs_to :sub

  belongs_to :post
end
