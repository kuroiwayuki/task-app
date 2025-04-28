class Task < ApplicationRecord
  enum status: { todo: 0, doing: 1, done: 2 }
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
end
