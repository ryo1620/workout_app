// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("@rails/activestorage").start();
require("channels");
require('jquery');
require("./custom");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import { Calendar } from '@fullcalendar/core';
import jaLocale from '@fullcalendar/core/locales/ja';
import dayGridPlugin from '@fullcalendar/daygrid';
import "bootstrap";
import "@fortawesome/fontawesome-free/js/all";
import "../stylesheets/application";

// Fullcalendar
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  
  if(calendarEl){
    var calendar = new Calendar(calendarEl, {
      plugins: [ dayGridPlugin ],
      locale: jaLocale,
      eventSources: [
        {
          url: 'calendar.json',
          color: '#2C3E50',
          textColor: 'white'
        },
        {
          url: 'mon_menus.json',
          color: 'transparent',
          textColor: 'black'
        },
        {
          url: 'tue_menus.json',
          color: 'transparent',
          textColor: 'black'
        },
        {
          url: 'wed_menus.json',
          color: 'transparent',
          textColor: 'black'
        },
        {
          url: 'thu_menus.json',
          color: 'transparent',
          textColor: 'black'
        },
        {
          url: 'fri_menus.json',
          color: 'transparent',
          textColor: 'black'
        },
        {
          url: 'sat_menus.json',
          color: 'transparent',
          textColor: 'black'
        },
        {
          url: 'sun_menus.json',
          color: 'transparent',
          textColor: 'black'
        }
      ]
    });
  
    calendar.render();
  }
});
