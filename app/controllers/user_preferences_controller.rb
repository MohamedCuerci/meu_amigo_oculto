class UserPreferencesController < ApplicationController
  before_action :set_user_preference, only: %i[ show edit update destroy ]

  # GET /user_preferences or /user_preferences.json
  def index
    @user_preferences = UserPreference.all
  end

  # GET /user_preferences/1 or /user_preferences/1.json
  def show
  end

  # GET /user_preferences/new
  def new
    @user_preference = UserPreference.new
  end

  # GET /user_preferences/1/edit
  def edit
  end

  # POST /user_preferences or /user_preferences.json
  def create
    @user_preference = UserPreference.new(user_preference_params)

    respond_to do |format|
      if @user_preference.save
        format.html { redirect_to @user_preference, notice: "User preference was successfully created." }
        format.json { render :show, status: :created, location: @user_preference }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_preferences/1 or /user_preferences/1.json
  def update
    respond_to do |format|
      if @user_preference.update(user_preference_params)
        format.html { redirect_to @user_preference, notice: "User preference was successfully updated." }
        format.json { render :show, status: :ok, location: @user_preference }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_preferences/1 or /user_preferences/1.json
  def destroy
    @user_preference.destroy!

    respond_to do |format|
      format.html { redirect_to user_preferences_path, status: :see_other, notice: "User preference was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_preference
      @user_preference = UserPreference.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_preference_params
      params.require(:user_preference).permit(:nickname, :age, :user_id)
    end
end
