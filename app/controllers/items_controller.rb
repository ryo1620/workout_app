class ItemsController < ApplicationController
  def index
    @items = Item.where(default: true)
             .or(Item.where(id: current_user.id)).page(params[:page]).per(12)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @part = Part.find(@item.part_id)
    @type = Type.find(@item.type_id)
  end

  def new
    @item = Item.new
    @part = Part.all
    @type = Type.all
  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to user_item_url(current_user, @item)
    else
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
    @part = Part.all
    @type = Type.all
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "種目を更新しました。"
      redirect_to user_item_url(current_user)
    else
      render 'edit'
    end
  end
  
  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "種目を削除しました。"
    redirect_to user_items_url(current_user)
  end
  
  private
  
    def item_params
      params.reqire(:item).permit(:name, :part, :type)
    end
end
