class WishListsController < ApplicationController
  before_action :set_wish_list, only: [:show, :edit, :update, :destroy]
  before_action :set_participant, only: [:index, :new, :create]

  def index
    # @wish_lists = WishList.includes(:participant).group_by(&:participant)
    # @santa_secret = SantaSecret.find_by(@participant.santa_secret.id)
    @wish_lists = WishList.where(participant_id: @participant.id)
  end

  def show; end

  def new
    @wish_list = @participant.wish_lists.build
  end

  def create
    @wish_list = @participant.wish_lists.new(wish_list_params)

    if @wish_list.save
      redirect_to participant_wish_lists_path(@participant), notice: 'Wish list created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @wish_list.update(wish_list_params)
      redirect_to wish_lists_path, notice: 'Desejo atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @wish_list.destroy
    redirect_to wish_lists_path, notice: 'Desejo removido com sucesso.'
  end

  private

  def set_wish_list
    @wish_list = WishList.find(params[:id])
  end

  def wish_list_params
    params.require(:wish_list).permit(:item, :description, :font_reference, :participant_id)
  end

  def set_participant
    @participant = Participant.find(params[:participant_id])
  end
end
