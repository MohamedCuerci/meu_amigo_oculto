class ParticipantsController < ApplicationController
  before_action :set_secret_santa

  def create
    user = User.find(params[:user_id])
    @participant = @secret_santa.participants.new(user: user)

    if @participant.save
      redirect_to @secret_santa, notice: 'Usuário adicionado com sucesso.'
    else
      redirect_to @secret_santa, alert: 'Não foi possível adicionar o usuário.'
    end
  end

  def join
    # Verifica se o usuário já é participante
    if @secret_santa.participants.exists?(user: current_user)
      redirect_to @secret_santa, alert: 'Você já está participando deste sorteio.'
    else
      @participant = @secret_santa.participants.new(user: current_user)
      # @participant = Participant.create!(user_id: current_user.id, secret_santa_id: @secret_santa.id)
      if @participant.save
        redirect_to @secret_santa, notice: 'Você entrou no sorteio com sucesso!'
      else
        redirect_to @secret_santa, alert: 'Houve um erro ao tentar participar do sorteio.'
      end
    end
  end

  private

  def set_secret_santa
    @secret_santa = SecretSanta.find(params[:secret_santa_id])
  end
end
