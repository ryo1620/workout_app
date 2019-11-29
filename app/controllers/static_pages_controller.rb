class StaticPagesController < ApplicationController
  before_action :initialize_records, only: :home
  protect_from_forgery except: :one_day
  
  def home
    if user_signed_in?
      @date = Date.today
      @menu_records = current_user.menu_records.where(date: @date)
      @message = "今日はお休みです。"
    else
      
    end
  end
  
  def one_day
    @date = params[:date].to_date
    data_to_render
  end
  
  def calendar
    @menu_records = current_user.menu_records
                      .where(checked: true)
                        .where.not(date: Date.today)
    respond_to do |format|
     format.html
     format.json { render 'calendar', handlers: 'jbuilder' }
    end
  end
  
  def mon_menus
    @mon_menus = current_user.week_menus.where(cwday: 1)
    respond_to do |format|
     format.json { render 'mon_menus', handlers: 'jbuilder' }
    end
  end
  
  def tue_menus
    @tue_menus = current_user.week_menus.where(cwday: 2)
    respond_to do |format|
     format.json { render 'tue_menus', handlers: 'jbuilder' }
    end
  end
  
  def wed_menus
    @wed_menus = current_user.week_menus.where(cwday: 3)
    respond_to do |format|
     format.json { render 'wed_menus', handlers: 'jbuilder' }
    end
  end
  
  def thu_menus
    @thu_menus = current_user.week_menus.where(cwday: 4)
    respond_to do |format|
     format.json { render 'thu_menus', handlers: 'jbuilder' }
    end
  end
  
  def fri_menus
    @fri_menus = current_user.week_menus.where(cwday: 5)
    respond_to do |format|
     format.json { render 'fri_menus', handlers: 'jbuilder' }
    end
  end
  
  def sat_menus
    @sat_menus = current_user.week_menus.where(cwday: 6)
    respond_to do |format|
     format.json { render 'sat_menus', handlers: 'jbuilder' }
    end
  end
  
  def sun_menus
    @sun_menus = current_user.week_menus.where(cwday: 7)
    respond_to do |format|
     format.json { render 'sun_menus', handlers: 'jbuilder' }
    end
  end

  def about
  end

  def contact
  end
  
  private
    
    # メニュー記録が存在しない場合、曜日メニューをもとに作成する
    def initialize_records
      if user_signed_in?
        date = Date.today
        cwday = date.cwday
        @menu_records = current_user.menu_records.where(date: date)
        @week_menus = current_user.week_menus.where(cwday: cwday)
        if @menu_records.blank? && @week_menus.present?
          @week_menus.each do |week_menu|
            menu = week_menu.menu
            @menu_record = current_user.menu_records.build(name: menu.name, date: date)
            @menu_record.save
            if (attributes = menu.menu_items).present?
              @item_records = ItemRecordCollection.new(attributes)
              @item_records.collection.each do |item_record|
                item_record.date = date
                item_record.menu_record_id = @menu_record.id
              end
              @item_records.save
            end
          end
        end
      end
    end
    
    def data_to_render
      @cwday = @date.cwday
      @week_menus = current_user.week_menus.where(cwday: @cwday)
      @menu_records = current_user.menu_records.where(date: @date)
      if @date > Date.today
        @message = "この日はお休みです。"
      elsif @date == Date.today
        @message = "今日はお休みです。"
      else
        @message = "この日はお休みでした。"
      end
      respond_to do |format|
        format.js
      end
    end
end
