class User < ApplicationRecord

  has_many :videos
  has_secure_password

  validates :email, presence: true, uniqueness: true, email: true
  validates :password_digest, length: { minimum: 6 }
end
