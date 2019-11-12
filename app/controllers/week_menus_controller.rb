class WeekMenusController < ApplicationController
  before_action :initialize_week_menus, only: [:create]
  
  def create
    @mon_menus = WeekMenuCollection.new(mon_menus_params)
    @tue_menus = WeekMenuCollection.new(tue_menus_params)
    @wed_menus = WeekMenuCollection.new(wed_menus_params)
    @thu_menus = WeekMenuCollection.new(thu_menus_params)
    @fri_menus = WeekMenuCollection.new(fri_menus_params)
    @sat_menus = WeekMenuCollection.new(sat_menus_params)
    @sun_menus = WeekMenuCollection.new(sun_menus_params)
    @mon_menus.save
    @tue_menus.save
    @wed_menus.save
    @thu_menus.save
    @fri_menus.save
    @sat_menus.save
    @sun_menus.save
    flash[:success] = "更新しました。"
    redirect_to user_menus_url(current_user)
  end
  
  private

    def mon_menus_params
      params.require(:mon_menus)
    end
    
    def tue_menus_params
      params.require(:tue_menus)
    end
    
    def wed_menus_params
      params.require(:wed_menus)
    end
    
    def thu_menus_params
      params.require(:thu_menus)
    end
    
    def fri_menus_params
      params.require(:fri_menus)
    end
    
    def sat_menus_params
      params.require(:sat_menus)
    end
    
    def sun_menus_params
      params.require(:sun_menus)
    end
    
    def initialize_week_menus
      @week_menus = WeekMenu.where(user_id: params[:user_id])
      if @week_menus.any? 
        @week_menus.destroy_all
      end
    end
end
