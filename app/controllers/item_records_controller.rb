class ItemRecordsController < ApplicationController
  
  def update
    @item_record = ItemRecord.find(params[:id])
    @item_record.update_attributes(item_record_params)
    menu_record = @item_record.menu_record
    item_records = menu_record.item_records
    if item_records.count == item_records.where(checked: true).count
      menu_record.update_attribute(:checked, true)
    else
      menu_record.update_attribute(:checked, false)
    end
  end
  
  private
  
    def item_record_params
      params.require(:item_record).permit(:checked)
    end
    
end
