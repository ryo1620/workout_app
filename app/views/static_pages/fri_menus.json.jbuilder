json.array!(@fri_menus) do |fri_menu|
  json.title fri_menu.menu.name
  json.daysOfWeek  [ '5' ]
  json.startRecur Date.today 
end