jQuery ->
  $('body').on 'click', 'button.close[data-dismiss=alert]', ->
    $(this).closest('div.alert').fadeOut();
