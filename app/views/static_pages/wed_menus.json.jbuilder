json.array!(@wed_menus) do |wed_menu|
  json.title wed_menu.menu.name
  json.daysOfWeek  [ '3' ]
  json.startRecur Date.today 
end