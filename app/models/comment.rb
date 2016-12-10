class Comment < ApplicationRecord
  validates :post_id, :content, :author_id, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  belongs_to :post

  has_many :child_comments,
    foreign_key: :parent_id,
    class_name: :Comment

  has_many :votes, as: :votable
  
end
