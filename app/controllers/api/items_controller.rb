class Api::ItemsController < ApplicationController

  before_action :ensure_logged_in

  def index
    @items = Item.all
  end

  def show
    @item = Item.find_by(id: params[:id])
  end

end
