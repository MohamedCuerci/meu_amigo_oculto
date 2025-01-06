namespace :amigo_oculto do
  desc "Adiciona todos os usuários como participantes no último amigo oculto"
  task add_participants: :environment do
    amigo_oculto = SecretSanta.last

    if amigo_oculto.nil?
      puts "Nenhum amigo oculto encontrado."
      exit
    end

    user_ids = User.pluck(:id)

    total_users = user_ids.count

    user_ids.each_with_index do |user_id, index|
      participantes = amigo_oculto.participants
      next if participantes.exists?(user_id: user_id)
      participantes.create!(user_id: user_id)

      print "\rAdicionando participantes: #{index + 1}/#{total_users}\n"
    end

    puts "Participantes adicionados com sucesso!"
  end
end

