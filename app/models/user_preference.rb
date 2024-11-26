class UserPreference < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture

  def initials
    nickname.split.map(&:first).join.upcase || user.email.split.map(&:first).join.upcase
  end
end
