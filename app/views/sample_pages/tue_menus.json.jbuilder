json.array!(@tue_menus) do |tue_menu|
  json.title tue_menu.menu.name
  json.daysOfWeek  [ '2' ]
  json.startRecur Date.today 
end