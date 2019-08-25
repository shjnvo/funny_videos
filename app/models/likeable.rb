class Likeable < ApplicationRecord
  belongs_to :video
  belongs_to :user

  validates :video_id, uniqueness: { scope: :user_id, message: "One User only like one video!!!" }
  validates :status, presence: true

  enum status: [:like, :dislike]
end
