class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  # association's
  has_one :user_preference, dependent: :destroy
  
  # callback's
  after_create :default_user_preference

  private

  def default_user_preference
    UserPreference.create!(user: self)
  end
end
