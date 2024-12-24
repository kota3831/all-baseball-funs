class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :post_comment, presence: true, length: { minimum: 2, maximum: 50 }
end
