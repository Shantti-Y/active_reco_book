$ ->
   $('div').not('#header').click ->
      $('#dropdown-notify').hide(0)
      $('#dropdown-menu').hide(0)
      $('#dropdown-user').hide(0)

   $('#header-menu').click ->
      $('#dropdown-notify').hide(0)
      $('#dropdown-user').hide(0)
      $('#dropdown-menu').slideToggle ->

   $('#header-notify').click ->
      $('#dropdown-menu').hide(0)
      $('#dropdown-user').hide(0)
      $('#dropdown-notify').slideToggle ->

   $('#header-user').click ->
      $('#dropdown-menu').hide(0)
      $('#dropdown-notify').hide(0)
      $('#dropdown-user').slideToggle ->
