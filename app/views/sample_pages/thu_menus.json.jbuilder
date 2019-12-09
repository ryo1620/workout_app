json.array!(@thu_menus) do |thu_menu|
  json.title thu_menu.menu.name
  json.daysOfWeek  [ '4' ]
  json.startRecur Date.today 
end