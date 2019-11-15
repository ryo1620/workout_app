class MenuItemsController < ApplicationController
  before_action :initialize_menu_items, only: [:create]
  
  def create
    @menu_items = MenuItemCollection.new(menu_items_params)
    @menu_items.each { |menu_item| menu_item.user_id = current_user.id }
    @menu_items.save
    flash[:success] = "保存しました。"
    redirect_to user_menus_url(current_user)
  end
  
  private
  
    def menu_items_params
      params.require(:menu_items)
    end
  
    def initialize_week_menus
      @menu_items = current_user.menus.find(params[:id]).menu_items
      if @menu_items.any? 
        @menu_items.destroy_all
      end
    end
  
end
