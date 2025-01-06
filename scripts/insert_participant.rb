

amigo_oculto = Secret_santa.last

user_ids = User.pluck(:id)

user_ids.each do |user_id|
  participantes = amigo_oculto.participants
  next if participantes.exists?(user_id: user_id)
  participantes.create!(user_id: user_id)
end

