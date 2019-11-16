class MenusController < ApplicationController
  before_action :week_menus_collection, only: [:index]
  
  def index
    @menus = current_user.menus.page(params[:page]).per(5)
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
  
  private

    def menu_params
      params.require(:menu).permit(:name)
    end
    
    # beforeアクション
    
    # 曜日メニューのセレクトボックス（モデル）を作成
    def week_menus_collection
      @week_menus = WeekMenuCollection.new
      @week_menus.collection = []
      1.upto(7) do |i|
        attributes = []
        attributes[i] = current_user.week_menus.where(cwday: i)
        if attributes[i].any?
          day_menus = WeekMenuCollection.new(attributes[i])
        else
          day_menus = WeekMenuCollection.new
        end
        @week_menus.collection.concat(day_menus.collection)
      end
    end
end
