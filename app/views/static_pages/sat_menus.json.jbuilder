json.array!(@sat_menus) do |sat_menu|
  json.title sat_menu.menu.name
  json.daysOfWeek  [ '6' ]
  json.startRecur Date.today 
end