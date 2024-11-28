class SecretSanta < ApplicationRecord
  # self.table_name = 'secret_santa'
  has_many :assignments
  # has_many :participants, through: :assignments, source: :giver
  has_many :participants
  has_many :users, through: :participants
  belongs_to :creator, class_name: 'User'
  has_one_attached :image, dependent: :destroy

  before_create :generate_unique_code

  # def started?
  #   # Logica pra saber se o sorteio ja começou
  #   matches.present?
  # end

  private

  def generate_unique_code
    self.code ||= ["#", SecureRandom.hex(6)].join
  end
end
