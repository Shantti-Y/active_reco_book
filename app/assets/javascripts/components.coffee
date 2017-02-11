$ ->
   # Button controller

      $('body').click ->
         if $('#header-menu').data('clicked')
            $('#dropdown-notify').hide(0)
            $('#dropdown-user').hide(0)
            $('#header-menu').data('clicked', false)
         else if $('#header-notify').data('clicked')
            $('#dropdown-menu').hide(0)
            $('#dropdown-user').hide(0)
            $('#header-notify').data('clicked', false)
         else if $('#header-user').data('clicked')
            $('#dropdown-menu').hide(0)
            $('#dropdown-notify').hide(0)
            $('#header-user').data('clicked', false)
         else
            $('#dropdown-notify').hide(0)
            $('#dropdown-menu').hide(0)
            $('#dropdown-user').hide(0)

      # header
      $('#header-menu').click ->
         $(this).data('clicked', true)
         $('#dropdown-menu').slideToggle ->
      $('#header-notify').click ->
         $(this).data('clicked', true)
         $('#dropdown-notify').slideToggle ->
      $('#header-user').click ->
         $(this).data('clicked', true)
         $('#dropdown-user').slideToggle ->

      # Flash
      removeFlash = () ->
         $('#flash').remove()
      $('#flash').click ->
         removeFlash()
