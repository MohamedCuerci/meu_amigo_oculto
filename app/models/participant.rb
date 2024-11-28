class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :secret_santa

  validates :user_id, uniqueness: { scope: :secret_santa_id, message: "já está participando deste sorteio." }
end
