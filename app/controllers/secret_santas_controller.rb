class SecretSantasController < ApplicationController
  before_action :set_secret_santa, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create edit update ]
  # validação para apenas o criador do sorteio conseguir apagar

  # GET /secret_santa or /secret_santa.json
  def index
    @secret_santas = SecretSanta.all
  end

  # GET /secret_santa/1 or /secret_santa/1.json
  def show
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

  # def find
  #   @secret_santa = SecretSanta.find_by(code: params[:code])
  #   if @secret_santa
  #     render json: @secret_santa
  #   else
  #     render json: { error: 'Sorteio não encontrado' }, status: :not_found
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secret_santa
      @secret_santa = SecretSanta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def secret_santa_params
      params.require(:secret_santa).permit(:name, :code, :description, :image, :event_type, :prize_date, :maximum_number)
    end
end
