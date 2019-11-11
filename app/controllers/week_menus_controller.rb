class WeekMenusController < ApplicationController
  
  private

    def week_menu_params
      params.require(:week_menu).permit(:cwday)
    end
end
