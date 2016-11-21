class Api::BidsController < ApplicationController

  before_action :ensure_logged_in
  before_action :ensure_correct_user, only: [:update, :create]

  def index
    if params[:user_id]
      @bids = User.find_by(id: params[:user_id]).bids.includes(:item).includes(:user)
      render :index
    elsif params[:item_id]
      @bid = Item.find_by(id: params[:item_id]).max_bid
      render :show
    end
  end

  def update
    @bid = Bid.find_by(id: params[:id])
    new_amount = bid_params.amount.to_i
    difference = new_amount - @bid.amount
    max_bid = Item.find_by(id: @bid.item_id).max_bid.amount
    if current_user.points >= difference && new_amount > max_bid
      @bid.amount = new_amount
      if @bid.save
        @user = User.find_by(id: @bid.user_id)
        @user.points -= difference
        @user.save
        render :show
      else
        @errors = @bid.errors.full_messages
        render json: @errors, status: 422
    else
      render json: ["bid error"], status: 422
    end
  end

  def create
    @bid = Bid.new(bid_params)
    @bid.user_id = current_user.id
    max_bid = Item.find_by(id: @bid.item_id).max_bid.amount
    if current_user.points >= @bid.amount.to_i && @bid.amount.to_i > max_bid
      if @bid.save
        @user = User.find_by(id: @bid.user_id)
        @user.points -= @bid.amount
        @user.save
        render :show
      else
        @errors = @bid.errors.full_messages
        render json: @errors, status: 422
      end
    else
      render json: ["bid error"], status: 422
    end
  end

  def bid_params
    params.require(:bid).permit(:item_id, :amount)
  end

end
