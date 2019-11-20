class MenuItemsController < ApplicationController
  before_action :initialize_menu_items, only: [:create]
  
  def create
    menu = Menu.find(params[:menu_id])
    @menu_items = MenuItemCollection.new(menu_items_params)
    @menu_items.collection.each do |menu_item| 
      menu_item.user_id = current_user.id
      menu_item.menu_id = params[:menu_id]
    end
    @menu_items.save
    flash[:success] = "保存しました。"
    redirect_to user_menu_url(current_user, menu)
  end
  
  def destroy_all
    menu = current_user.menus.find(params[:menu_id])
    menu_items = menu.menu_items
    menu_items.destroy_all if menu_items.any? 
    flash[:success] = "メニュー内容をリセットしました。"
    redirect_to user_menu_url(current_user, menu)
  end
  
  private
  
    def menu_items_params
      params.require(:menu_items)
    end
  
    def initialize_menu_items
      menu_items = current_user.menus.find(params[:menu_id]).menu_items
      menu_items.destroy_all if menu_items.any? 
    end
  
end
