class MenusController < ApplicationController
  before_action :week_menus_collection, only: [:index]
  
  def index
    @menus = Menu.where(user_id: params[:user_id])
  end

  def show
  end

  def new
  end

  def edit
  end
  
  private

    def menu_params
      params.require(:menu).permit(:name)
    end
    
    # beforeアクション
    
    # 曜日メニューのセレクトボックス（モデル）を作成
    def week_menus_collection
      attributes = []
      1.upto(7) do |i|
        attributes[i] = WeekMenu.where(cwday: i, user_id: params[:user_id])
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
