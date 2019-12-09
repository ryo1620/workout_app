json.array!(@mon_menus) do |mon_menu|
  json.title mon_menu.menu.name
  json.daysOfWeek  [ '1' ]
  json.startRecur Date.today 
end