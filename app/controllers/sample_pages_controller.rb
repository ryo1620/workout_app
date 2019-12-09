class SamplePagesController < ApplicationController
  
  def one_day
    @user = User.find(2)
    @date = params[:date].to_date
    @cwday = @date.cwday
    @week_menus = @user.week_menus.where(cwday: @cwday)
    @menu_records = @user.menu_records.where(date: @date)
    if @date > Date.today
      @message = "この日はお休みです。"
    elsif @date == Date.today
      @message = "今日はお休みです。"
    else
      @message = "この日はお休みでした。"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def calendar
    @user = User.find(2)
    @menu_records = @user.menu_records
                      .where(checked: true)
                        .where.not(date: Date.today)
    respond_to do |format|
     format.html
     format.json { render 'calendar', handlers: 'jbuilder' }
    end
  end
  
  def mon_menus
    @user = User.find(2)
    @mon_menus = @user.week_menus.where(cwday: 1)
    respond_to do |format|
     format.json { render 'mon_menus', handlers: 'jbuilder' }
    end
  end
  
  def tue_menus
    @user = User.find(2)
    @tue_menus = @user.week_menus.where(cwday: 2)
    respond_to do |format|
     format.json { render 'tue_menus', handlers: 'jbuilder' }
    end
  end
  
  def wed_menus
    @user = User.find(2)
    @wed_menus = @user.week_menus.where(cwday: 3)
    respond_to do |format|
     format.json { render 'wed_menus', handlers: 'jbuilder' }
    end
  end
  
  def thu_menus
    @user = User.find(2)
    @thu_menus = @user.week_menus.where(cwday: 4)
    respond_to do |format|
     format.json { render 'thu_menus', handlers: 'jbuilder' }
    end
  end
  
  def fri_menus
    @user = User.find(2)
    @fri_menus = @user.week_menus.where(cwday: 5)
    respond_to do |format|
     format.json { render 'fri_menus', handlers: 'jbuilder' }
    end
  end
  
  def sat_menus
    @user = User.find(2)
    @sat_menus = @user.week_menus.where(cwday: 6)
    respond_to do |format|
     format.json { render 'sat_menus', handlers: 'jbuilder' }
    end
  end
  
  def sun_menus
    @user = User.find(2)
    @sun_menus = @user.week_menus.where(cwday: 7)
    respond_to do |format|
     format.json { render 'sun_menus', handlers: 'jbuilder' }
    end
  end
  
  def week_menus
    @user = User.find(2)
    @week_menus = WeekMenuCollection.new
    @week_menus.collection = []
    1.upto(7) do |i|
      attributes = []
      attributes[i] = @user.week_menus.where(cwday: i)
      if attributes[i].any?
        day_menus = WeekMenuCollection.new(attributes[i])
      else
        day_menus = WeekMenuCollection.new
      end
      @week_menus.collection.concat(day_menus.collection)
    end
  end
  
  def menus
    @user = User.find(2)
    @menus = @user.menus.page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new_menu
    @menu = Menu.new
  end
  
  def menu
    @menu = Menu.find(params[:menu_id])
    @menu_items = @menu.menu_items
  end
  
  def edit_menu
    @menu = Menu.find(params[:menu_id])
  end
  
  def menu_items
    @user = User.find(2)
    @menu = Menu.find(params[:menu_id])
    @items = Item.where(default: true)
              .or(Item.where(user_id: @user.id))
                .order("name")
    attributes = []
    attributes = @user.menus.find(params[:menu_id]).menu_items
    if attributes.any?
      @menu_items = MenuItemCollection.new(attributes)
    else
      @menu_items = MenuItemCollection.new
    end
    # 部位・タイプのセレクトボックスに使う配列を生成する
    prompt = [
              ["部位・タイプで選ぶ", 
               data: {
                 children_path: menu_items_dynamic_items_path
               }
              ],
              ["全て",
                data: {
                 children_path: menu_items_dynamic_items_path
                }
              ]
             ]
    parts = [["---- 部位 ----",
              data: {
                children_path: menu_items_dynamic_items_path
              }
            ]] +
            Part.order(:id).map {
              |p| [p.name, data: {
                children_path: menu_items_dynamic_items_path(part_id: p.id)
                }
              ]
            }
    types = [["---- タイプ ----",
              data: {
                children_path: menu_items_dynamic_items_path
                }
            ]] +
            Type.order(:id).map {
              |t| [t.name, data: {
                children_path: menu_items_dynamic_items_path(type_id: t.id)
                }
              ]
            }
    @parts_types = prompt + parts + types
  end
  
  def dynamic_items
    @user = User.find(2)
    # ユーザーの選択に応じてjsの動作を分ける
    if params[:part_id]
      part = Part.find(params[:part_id])
      render json: Item.where(default: true, part_id: part.id)
                    .or(Item.where(user_id: @user.id, part_id: part.id))
                      .order("name").select(:id, :name)
    elsif params[:type_id]
      type = Type.find(params[:type_id])
      render json: Item.where(default: true, type_id: type.id)
                    .or(Item.where(user_id: @user.id, type_id: type.id))
                      .order("name").select(:id, :name)
    else
      render json: Item.where(default: true)
                    .or(Item.where(user_id: @user.id))
                      .order("name").select(:id, :name) 
    end
  end
  
  def items
    @user = User.find(2)
    @items = Item.where(default: true)
              .or(Item.where(user_id: @user.id))
                .order("name").page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
    # 部位・タイプのプルダウンに使う配列を生成する
    prompt = [["部位・タイプで探す"], ["全て"]]
    parts = [["---- 部位 ----"]] + Part.order(:id).map { |p| [p.name] }
    types = [["---- タイプ ----"]] + Type.order(:id).map { |t| [t.name] }
    @parts_types = prompt + parts + types
  end
  
  def search
    @user = User.find(2)
    # プルダウンの選択に応じてインスタンス変数に種目一覧を代入する
    if part = Part.find_by(name: params[:parts_types])
      @items = Item.where(default: true, part_id: part.id)
                .or(Item.where(user_id: @user.id, part_id: part.id))
                  .order("name").page(params[:page]).per(10)
    elsif type = Type.find_by(name: params[:parts_types])
      @items = Item.where(default: true, type_id: type.id)
                .or(Item.where(user_id: @user.id, type_id: type.id))
                  .order("name").page(params[:page]).per(10)
    else
      @items = Item.where(default: true)
                .or(Item.where(user_id: @user.id))
                  .order("name").page(params[:page]).per(10)
    end
  end
  
  def new_item
    @item = Item.new
    @parts = Part.all
    @types = Type.all
  end
  
  def item
    @user = User.find(2)
    @item = Item.find(params[:item_id])
    @part = Part.find(@item.part_id)
    @type = Type.find(@item.type_id)
  end
  
  def edit_item
    @item = Item.find(params[:item_id])
    @parts = Part.all
    @types = Type.all
  end
  
  def sample_user
    @user = User.find(2)
  end
end
