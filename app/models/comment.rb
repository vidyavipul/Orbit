class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :body, presence: true, length: { maximum: 300 }
end
