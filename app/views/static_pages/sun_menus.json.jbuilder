json.array!(@sun_menus) do |sun_menu|
  json.title sun_menu.menu.name
  json.daysOfWeek  [ '0' ]
  json.startRecur Date.today 
end