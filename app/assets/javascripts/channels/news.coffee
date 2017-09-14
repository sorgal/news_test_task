App.messages = App.cable.subscriptions.create 'NewsChannel',
  received: (data) ->
    $('#news_title').text(data.title)
    $('#news_published_at').text("#{data.date} #{data.time}")
    $('#news_description').text(data.descr)
    $('#news').show()
