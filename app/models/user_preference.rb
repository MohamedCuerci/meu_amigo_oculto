class UserPreference < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture
  validates :nickname, presence: true

  def initials
    nickname.split.map(&:first).join.upcase[..2] || user.email.split.map(&:first).join.upcase
  end
end
