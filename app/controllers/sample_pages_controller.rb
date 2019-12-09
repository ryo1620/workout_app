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
end
