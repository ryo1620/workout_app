class MenusController < ApplicationController
  def index
    @week_menu = WeekMenu.new
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
    
end
