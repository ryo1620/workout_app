class WeekMenusController < ApplicationController
  before_action :initialize_week_menus, only: [:create]
  
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
    redirect_to user_menus_url(current_user)
  end
  
  private

    def week_menus_params
      params.require(:week_menus)
    end
    
    def initialize_week_menus
      @week_menus = current_user.week_menus
      if @week_menus.any? 
        @week_menus.destroy_all
      end
    end
end
