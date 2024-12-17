class SecretSantasController < ApplicationController
  include Pagy::Backend
  before_action :set_secret_santa, only: %i[ show edit update destroy draw ]
  before_action :authenticate_user!, only: %i[ new create edit update my_secret_santas ]

  # GET /secret_santa or /secret_santa.json
  def index
    @q = SecretSanta.ransack(params[:q])
    @pagy, @secret_santas = pagy(@q.result(distinct: true))
  end

  def my_secret_santas
    @secret_santas = SecretSanta.joins(:participants).where(participants: { user_id: current_user.id })

    @secret_santa_completed = @secret_santas.completed
    @secret_santa_pending = @secret_santas.pending
  end

  # GET /secret_santa/1 or /secret_santa/1.json
  def show
    @participants = @secret_santa.participants.includes(:user).sort_by do |participant|
      participant.user == current_user ? 0 : 1
    end
  end

  # GET /secret_santa/new
  def new
    @secret_santa = SecretSanta.new
  end

  # GET /secret_santa/1/edit
  def edit
  end

  # POST /secret_santa or /secret_santa.json
  def create
    @secret_santa = SecretSanta.new(secret_santa_params)
    @secret_santa.creator = current_user
    # @secret_santa.creator_id = current_user.id

    respond_to do |format|
      if @secret_santa.save
        format.html { redirect_to @secret_santa, notice: "Secret santum was successfully created." }
        format.json { render :show, status: :created, location: @secret_santa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @secret_santa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secret_santa/1 or /secret_santa/1.json
  def update
    respond_to do |format|
      if @secret_santa.update(secret_santa_params)
        format.html { redirect_to @secret_santa, notice: "Secret santum was successfully updated." }
        format.json { render :show, status: :ok, location: @secret_santa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @secret_santa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secret_santa/1 or /secret_santa/1.json
  def destroy
    @secret_santa.destroy!

    respond_to do |format|
      format.html { redirect_to secret_santa_path, status: :see_other, notice: "Secret santum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def draw
    # secret_santa = SecretSanta.find(params[:id])

    if @secret_santa.amigo_oculto?
      # amigo oculto
      @secret_santa.perform_draw
      # aqui atualizado o status do sorteio
      redirect_to secret_santa_path(@secret_santa), notice: "Sorteio realizado com sucesso!"
    else
      # sorteio
      # @secret_santa.perfom_prize_draw
      # redirect_to secret_santa_path(@secret_santa), alert: "O tipo de evento não é válido para sorteio."
    end
  rescue StandardError => e
    redirect_to secret_santa_path(@secret_santa), alert: "Erro ao realizar o sorteio: #{e.message}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secret_santa
      @secret_santa = SecretSanta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def secret_santa_params
      params.require(:secret_santa).permit(:name, :code, :description, :image, :event_type, :prize_date, :maximum_number, :address, :gift_value, :winner)
    end
end
