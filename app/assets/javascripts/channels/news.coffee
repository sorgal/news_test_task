App.messages = App.cable.subscriptions.create 'NewsChannel',
  received: (data) ->
    $('#news_title').text(data.title)
    $('#news_published_at').text(data.datetime)
    $('#news_description').html(data.descr)
    $('#news').show()
