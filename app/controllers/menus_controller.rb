class MenusController < ApplicationController
  before_action :week_menu_collections, only: [:index]
  
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
    def week_menu_collections
      attributes = []
      1.upto(7) do |i|
        attributes[i] = current_user.week_menus.where(cwday: i)
      end
      if attributes[1].any?
        @mon_menus = WeekMenuCollection.new(attributes[1])
      else
        @mon_menus = WeekMenuCollection.new
      end
      if attributes[2].any?
        @tue_menus = WeekMenuCollection.new(attributes[2])
      else
        @tue_menus = WeekMenuCollection.new
      end
      if attributes[3].any?
        @wed_menus = WeekMenuCollection.new(attributes[3])
      else
        @wed_menus = WeekMenuCollection.new
      end
      if attributes[4].any?
        @thu_menus = WeekMenuCollection.new(attributes[4])
      else
        @thu_menus = WeekMenuCollection.new
      end
      if attributes[5].any?
        @fri_menus = WeekMenuCollection.new(attributes[5])
      else
        @fri_menus = WeekMenuCollection.new
      end
      if attributes[6].any?
        @sat_menus = WeekMenuCollection.new(attributes[6])
      else
        @sat_menus = WeekMenuCollection.new
      end
      if attributes[7].any?
        @sun_menus = WeekMenuCollection.new(attributes[7])
      else
        @sun_menus = WeekMenuCollection.new
      end
    end
end
