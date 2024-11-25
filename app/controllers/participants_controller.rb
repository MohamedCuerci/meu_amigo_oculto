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

  private

  def set_secret_santa
    @secret_santa = SecretSanta.find(params[:secret_santa_id])
  end
end
