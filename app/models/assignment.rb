class Assignment < ApplicationRecord
  belongs_to :secret_santa
  belongs_to :giver, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  # logica para sorteio
  def perform_draw(secret_santa)
    participants = secret_santa.participants.to_a # talvez precise mudar essa linha
    shuffled = participants.shuffle
  
    participants.each_with_index do |giver, i|
      receiver = shuffled[i]
      receiver = shuffled.rotate[i] if giver == receiver # Evitar autoatribuição
  
      Assignment.create!(
        secret_santa: secret_santa,
        giver: giver,
        receiver: receiver
      )
    end
  end  
end
