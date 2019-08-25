class Video < ApplicationRecord
  belongs_to :user

  validates :uuid, uniqueness: true

  def action_by(user)
    Likeable.find_by(video_id: id, user_id: user.id)
  end
end
