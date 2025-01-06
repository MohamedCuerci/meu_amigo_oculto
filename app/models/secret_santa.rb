class SecretSanta < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  belongs_to :creator, class_name: 'User'
  has_one_attached :image, dependent: :destroy

  before_create :generate_unique_code
  after_create :set_first_participant

  enum event_type: { sorteio: 0, amigo_oculto: 1 }
  enum status: { pending: 0, completed: 1 } # finished?

  def self.ransackable_attributes(auth_object = nil)
    ["address", "code", "created_at", "creator_id", "description", "event_type", "gift_value", "id", "id_value", "maximum_number", "name", "prize_date", "status", "updated_at", "winner"]
  end

  def perform_draw
    participant_ids = participants.pluck(:id)
    
    raise "O sorteio precisa de pelo menos 2 participantes." if participant_ids.size < 2
    
    draw_result = generate_secret_santa_draw(participant_ids)

    ActiveRecord::Base.transaction do
      assignments.destroy_all # Remove atribuições anteriores, caso existam
      draw_result.each do |giver_id, receiver_id|
        assignments.create!(secret_santa_id: self.id, giver_id: giver_id, receiver_id: receiver_id)
      end
      update!(status: :completed)
    end
  end

  def user_in_event?(user_id)
    return if user_id.nil?
    participants.pluck(:user_id).include?(user_id)
  end

  private

  def generate_secret_santa_draw(participant_ids)
    # aqui seria legal colocar num job pra executar
    loop do
      shuffled_ids = participant_ids.shuffle
      valid_draw = participant_ids.each_with_index.none? { |id, index| id == shuffled_ids[index] }
      return participant_ids.zip(shuffled_ids) if valid_draw
    end
  end

  def set_first_participant
    Participant.create!(user_id: creator.id, secret_santa_id: self.id)
  end

  def generate_unique_code
    self.code ||= ["#", SecureRandom.hex(6)].join
  end
end
