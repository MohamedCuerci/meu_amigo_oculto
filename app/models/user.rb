class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  # association's
  has_many :given_assignments, class_name: 'Assignment', foreign_key: 'giver_id'
  has_many :received_assignments, class_name: 'Assignment', foreign_key: 'receiver_id'
  has_many :participants
  has_many :secret_santas, through: :participants
  has_one :user_preference, dependent: :destroy
  accepts_nested_attributes_for :user_preference

end
