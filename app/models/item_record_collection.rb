class ItemRecordCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  attr_accessor :collection  # ここに作成したモデルが格納される

  # 初期化メソッド
  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        ItemRecord.new(
          name: Item.find(value[:item_id]).name,
          weight: value[:weight],
          reps: value[:reps],
          seconds: value[:seconds],
          sets: value[:sets],
          user_id: value[:user_id]
        )
      end
    else
      self.collection = []
    end
  end

  # レコードが存在するか確認するメソッド
  def persisted?
    false
  end
  
  # コレクションをDBに保存するメソッド
  def save
    collection.each do |result|
      result.save
    end
  end
end