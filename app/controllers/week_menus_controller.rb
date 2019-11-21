class WeekMenusController < ApplicationController
  before_action :initialize_week_menus, only: [:create]
  
  def index
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
  
  def create
    @week_menus = WeekMenuCollection.new(week_menus_params)
    i = 0
    @week_menus.collection.each_slice(3) do |day_menus|
      i += 1
      day_menus.each do |day_menu|
        day_menu.cwday = i
        day_menu.user_id = current_user.id
      end
    end
    @week_menus.save
    flash[:success] = "更新しました。"
    redirect_to user_week_menus_url(current_user)
  end
  
  def destroy_all
    week_menus = current_user.week_menus
    week_menus.destroy_all if week_menus.any? 
    flash[:success] = "リセットしました。"
    redirect_to user_week_menus_url(current_user)
  end
  
  private

    def week_menus_params
      params.require(:week_menus)
    end
    
    # beforeアクション
    
    def initialize_week_menus
      week_menus = current_user.week_menus
      week_menus.destroy_all if week_menus.any? 
    end
end
