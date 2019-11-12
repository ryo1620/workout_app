class WeekMenuCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  NUM = 3  # 同時にモデルを作成する数
  attr_accessor :collection  # ここに作成したモデルが格納される

  # 初期化メソッド
  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        WeekMenu.new(
          cwday: value[:cwday],
          user_id: value[:user_id],
          menu_id: value[:menu_id]
        )
      end
      self.collection += (NUM - attributes.count).times.map{ WeekMenu.new }
    else
      self.collection = NUM.times.map{ WeekMenu.new }
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