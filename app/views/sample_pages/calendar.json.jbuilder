json.array!(@menu_records) do |menu_record|
  json.title menu_record.name
  json.start menu_record.date   
  json.end menu_record.date 
end