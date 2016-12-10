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

  has_many :votes, as: :votable

  def comments_by_parent_id
    hash = Hash.new { |h, k| h[k] = [] }
    Comment.where(post_id: self.id).each do |comment|
      hash[comment.parent_id] << comment
    end
    hash
  end
end
