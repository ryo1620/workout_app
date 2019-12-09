class MenuRecordsController < ApplicationController
  
  def update
    @menu_record = MenuRecord.find(params[:id])
    @menu_record.update(menu_record_params)
  end
  
  def destroy_all
    date = Date.today
    menu_records = current_user.menu_records.where(date: date)
    menu_records.destroy_all if menu_records.any? 
    flash[:success] = "メニューを上書きしました。"
    redirect_to root_url
  end
  
  private
  
    def menu_record_params
      params.require(:menu_record).permit(:checked)
    end
  
end
