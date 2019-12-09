class MenusController < ApplicationController
  
  def index
    @menus = current_user.menus.page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @menu = Menu.find(params[:id])
    @menu_items = @menu.menu_items
  end

  def new
    @menu = Menu.new
  end
  
  def create
    @menu = current_user.menus.build(menu_params)
    if @menu.save
      redirect_to user_menu_menu_items_url(current_user, @menu)
    else
      render 'new'
    end
  end

  def edit
    @menu = Menu.find(params[:id])
  end
  
  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      flash[:success] = "メニュー名を更新しました。"
      redirect_to user_menu_url(current_user)
    else
      render 'edit'
    end
  end
  
  def destroy
    Menu.find(params[:id]).destroy
    flash[:success] = "メニューを削除しました。"
    redirect_to user_menus_url(current_user)
  end
  
  private

    def menu_params
      params.require(:menu).permit(:name)
    end
end
