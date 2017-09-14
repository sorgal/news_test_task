class News::FromYandex < NewsRoot

  def perform_request
    news_info = JSON.parse("{#{Typhoeus.get(YANDEX_NEWS_URL).body.force_encoding('utf-8')
                                       .scan(/\{(.*?)\}/).flatten.first}}")
    broadcast(news_info)                                   
    store_to_redis(YANDEX_NEWS_KEY, news_info.to_a.flatten)
  end
end
