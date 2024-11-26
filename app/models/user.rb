class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  # association's
  has_one :user_preference, dependent: :destroy
  has_many :given_assignments, class_name: 'Assignment', foreign_key: 'giver_id'
  has_many :received_assignments, class_name: 'Assignment', foreign_key: 'receiver_id'
  has_many :participants
  has_many :secret_santas, through: :participants
  
  # callback's
  after_create :default_user_preference

  private

  def default_user_preference
    UserPreference.create!(user: self)
  end

  # def initials
  #   email.split.map(&:first).join.upcase 
  # end
end
