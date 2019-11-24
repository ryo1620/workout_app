class ItemRecordsController < ApplicationController
  
  def update
    @item_record = ItemRecord.find(params[:id])
    @item_record.update_attributes(item_record_params)
  end
  
  private
  
    def item_record_params
      params.require(:item_record).permit(:checked)
    end
    
end
