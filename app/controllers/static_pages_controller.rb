class StaticPagesController < ApplicationController
  before_action :initialize_records, only: :home
  
  def home
    if user_signed_in?
      @date = Date.today
      @menu_records = current_user.menu_records.where(date: @date)
      @message = "今日はお休みです。"
    else
      
    end
  end
  
  def next_day
    @date = params[:date].to_date + 1
    data_to_render
  end
  
  def previous_day
    @date = params[:date].to_date - 1
    data_to_render
  end
  
  def calendar
    @menu_records = current_user.menu_records
    respond_to do |format|
     format.html
     format.json { render 'calendar', handlers: 'jbuilder' }
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
        format.html
        format.js
      end
    end
end
