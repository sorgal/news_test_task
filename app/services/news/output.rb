class News::Output < NewsRoot

  def output_news_record
    record = redis.hgetall(ADMIN_NEWS_KEY)
    record = redis.hgetall(YANDEX_NEWS_KEY) if record.empty?
    record
  end
end
