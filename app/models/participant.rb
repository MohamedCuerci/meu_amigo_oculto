class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :secret_santa
  has_many :wish_lists, dependent: :destroy
  has_many :given_assignments, class_name: 'Assignment', foreign_key: 'giver_id'
  has_many :received_assignments, class_name: 'Assignment', foreign_key: 'receiver_id'

  validates :user_id, uniqueness: { scope: :secret_santa_id, message: "já está participando deste sorteio." }
end
