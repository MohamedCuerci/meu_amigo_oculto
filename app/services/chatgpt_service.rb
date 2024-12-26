class ChatgptService
  def initialize
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key))
  end

  def generate_links(item)
    prompt = <<~PROMPT
      Você é um assistente que ajuda as pessoas a encontrar itens para compra. 
      O item buscado é: "#{item}". 
      Por favor, forneça 3 links de lojas confiáveis onde este item pode ser encontrado.
    PROMPT

    with_retries do 
      response = @client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [{ role: "user", content: prompt }],
          temperature: 0.7
        }
      )
      extract_links(response)
    end
  end

  private

  def with_retries(max_retries: 5, base_delay: 2) # 2s
    attempts = 0

    begin
      attempts += 1
      yield
    rescue Faraday::TooManyRequestsError => e
      raise e if attempts >= max_retries

      sleep(base_delay**attempts)
      retry
    end
  end

  def extract_links(response)
    message = response.dig("choices", 0, "message", "content")
    links = message.scan(%r{https?://[^\s]+})
    links.take(3)
  end
end