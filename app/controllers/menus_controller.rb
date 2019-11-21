class MenusController < ApplicationController
  
  def index
    @menus = current_user.menus.page(params[:page]).per(12)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @menu = Menu.find(params[:id])
    attributes = []
    attributes = current_user.menus.find(params[:id]).menu_items
    if attributes.any?
      @menu_items = MenuItemCollection.new(attributes)
    else
      @menu_items = MenuItemCollection.new
    end
    # 部位・タイプのセレクトボックスに使う配列を生成する
    prompt = [["部位・タイプで選ぶ", data: { 
    children_path: user_menu_dynamic_items_path(current_user, @menu) }]]
    parts = [["---- 部位 ----", data: { 
    children_path: user_menu_dynamic_items_path(current_user, @menu) }]] + Part.order(:id).map { |p| 
    [p.name, data: { children_path: user_menu_dynamic_items_path(current_user, @menu, part_id: p.id) }] }
    types = [["---- タイプ ----", data: { 
    children_path: user_menu_dynamic_items_path(current_user, @menu) }]] + Type.order(:id).map { |t| 
    [t.name, data: { children_path: user_menu_dynamic_items_path(current_user, @menu, type_id: t.id) }] }
    @parts_types = prompt + parts + types
  end
  
  def dynamic_items
    # ユーザーの選択に応じてjsの動作を分ける
    if params[:part_id]
      part = Part.find(params[:part_id])
      render json: part.items.where(user_id: current_user.id).select(:id, :name)
    elsif params[:type_id]
      type = Type.find(params[:type_id])
      render json: type.items.where(user_id: current_user.id).select(:id, :name)
    else
      render json: Item.where(user_id: current_user.id).select(:id, :name) 
    end
  end

  def new
    @menu = Menu.new
  end
  
  def create
    @menu = current_user.menus.build(menu_params)
    if @menu.save
      redirect_to user_menu_url(current_user, @menu)
    else
      render 'new'
    end
  end

  def edit
    @menu = Menu.find(params[:id])
  end
  
  def update
    @menu = Menu.find(params[:id])
    if @menu.update_attributes(menu_params)
      flash[:success] = "メニュー名を更新しました。"
      redirect_to user_menu_url(current_user)
    else
      render 'edit'
    end
  end
  
  def destroy
    Menu.find(params[:id]).destroy
    flash[:success] = "メニューを削除しました。"
    redirect_to user_menus_url(current_user)
  end
  
  private

    def menu_params
      params.require(:menu).permit(:name)
    end
end
