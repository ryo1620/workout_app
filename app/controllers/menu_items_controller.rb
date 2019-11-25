class MenuItemsController < ApplicationController
  before_action :initialize_menu_items, only: :create
  
  def index
    @menu = Menu.find(params[:menu_id])
    @items = Item.where(default: true)
              .or(Item.where(user_id: current_user.id))
                .order("name")
    attributes = []
    attributes = current_user.menus.find(params[:menu_id]).menu_items
    if attributes.any?
      @menu_items = MenuItemCollection.new(attributes)
    else
      @menu_items = MenuItemCollection.new
    end
    # 部位・タイプのセレクトボックスに使う配列を生成する
    prompt = [
              ["部位・タイプで選ぶ", 
               data: {
                 children_path: user_menu_menu_items_dynamic_items_path(current_user, @menu)
               }
              ],
              ["全て",
                data: {
                 children_path: user_menu_menu_items_dynamic_items_path(current_user, @menu)
                }
              ]
             ]
    parts = [["---- 部位 ----",
              data: {
                children_path: user_menu_menu_items_dynamic_items_path(current_user, @menu)
              }
            ]] +
            Part.order(:id).map {
              |p| [p.name, data: {
                children_path: user_menu_menu_items_dynamic_items_path(current_user, @menu,part_id: p.id)
                }
              ]
            }
    types = [["---- タイプ ----",
              data: {
                children_path: user_menu_menu_items_dynamic_items_path(current_user, @menu)
                }
            ]] +
            Type.order(:id).map {
              |t| [t.name, data: {
                children_path: user_menu_menu_items_dynamic_items_path(current_user, @menu, type_id: t.id)
                }
              ]
            }
    @parts_types = prompt + parts + types
  end
  
  def dynamic_items
    # ユーザーの選択に応じてjsの動作を分ける
    if params[:part_id]
      part = Part.find(params[:part_id])
      render json: Item.where(default: true, part_id: part.id)
                    .or(Item.where(user_id: current_user.id, part_id: part.id))
                      .order("name").select(:id, :name)
    elsif params[:type_id]
      type = Type.find(params[:type_id])
      render json: Item.where(default: true, type_id: type.id)
                    .or(Item.where(user_id: current_user.id, type_id: type.id))
                      .order("name").select(:id, :name)
    else
      render json: Item.where(default: true)
                    .or(Item.where(user_id: current_user.id))
                      .order("name").select(:id, :name) 
    end
  end
  
  def create
    menu = Menu.find(params[:menu_id])
    @menu_items = MenuItemCollection.new(menu_items_params)
    @menu_items.collection.each do |menu_item| 
      menu_item.user_id = current_user.id
      menu_item.menu_id = params[:menu_id]
    end
    @menu_items.save
    flash[:success] = "メニュー内容を保存しました。"
    redirect_to user_menu_url(current_user, menu)
  end
  
  def destroy_all
    menu = current_user.menus.find(params[:menu_id])
    menu_items = menu.menu_items
    menu_items.destroy_all if menu_items.any? 
    flash[:success] = "メニュー内容をリセットしました。"
    redirect_to user_menu_menu_items_url(current_user, menu)
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
