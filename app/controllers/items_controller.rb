class ItemsController < ApplicationController
  
  def index
    @items = Item.where(default: true)
              .or(Item.where(user_id: current_user.id))
                .order("name").page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
    # 部位・タイプのプルダウンに使う配列を生成する
    prompt = [["部位・タイプで探す"], ["全て"]]
    parts = [["---- 部位 ----"]] + Part.order(:id).map { |p| [p.name] }
    types = [["---- タイプ ----"]] + Type.order(:id).map { |t| [t.name] }
    @parts_types = prompt + parts + types
  end
  
  def search
    # プルダウンの選択に応じてインスタンス変数に種目一覧を代入する
    if part = Part.find_by(name: params[:parts_types])
      @items = Item.where(default: true, part_id: part.id)
                .or(Item.where(user_id: current_user.id, part_id: part.id))
                  .order("name").page(params[:page]).per(10)
    elsif type = Type.find_by(name: params[:parts_types])
      @items = Item.where(default: true, type_id: type.id)
                .or(Item.where(user_id: current_user.id, type_id: type.id))
                  .order("name").page(params[:page]).per(10)
    else
      @items = Item.where(default: true)
                .or(Item.where(user_id: current_user.id))
                  .order("name").page(params[:page]).per(10)
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @part = Part.find(@item.part_id)
    @type = Type.find(@item.type_id)
  end

  def new
    @item = Item.new
    @parts = Part.all
    @types = Type.all
  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "種目を作成しました。"
      redirect_to user_item_url(current_user, @item)
    else
      @parts = Part.all
      @types = Type.all
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
    @parts = Part.all
    @types = Type.all
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
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
      params.require(:item).permit(:name, :part_id, :type_id)
    end
end
