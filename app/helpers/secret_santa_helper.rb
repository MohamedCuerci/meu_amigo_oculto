module SecretSantaHelper
  def progress_percentage(secret_santa)
    max_participants = secret_santa.maximum_number || 1 # Evita divisão por zero
    current_participants = secret_santa.participants.count
    [(current_participants * 100 / max_participants.to_f).round, 100].min
  end

  def progress_bar(secret_santa)
    progress = progress_percentage(secret_santa)
    content_tag(:div, class: "d-flex align-items-center") do
      # Porcentagem à esquerda
      content_tag(:span, "#{progress}%", class: "me-2") +
      # Barra de progresso
      content_tag(:div, class: "progress flex-grow-1", style: "height: 10px;") do
        content_tag(:div, "", 
                    class: "progress-bar bg-success",
                    role: "progressbar",
                    style: "width: #{progress}%;",
                    aria: { valuenow: progress, valuemin: 0, valuemax: 100 })
      end
    end
  end
end
