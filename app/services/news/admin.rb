class News::Admin < NewsRoot

  def save_admin_news_record(params, expire)
    now = Time.now
    expires_at = (Time.parse(expire) - now).round
    date, time = now.strftime('%d.%m.%Y %H:%M').split(' ')
    publish_date_time = { 'date' => date, 'time' => time }
    news_record_data = params.merge!(publish_date_time).to_h
    store_to_redis(ADMIN_NEWS_KEY, news_record_data.to_a.flatten)
    broadcast(news_record_data)
    redis.expire(ADMIN_NEWS_KEY, expires_at)
    UpdateNewsRecord.enqueue(run_at: expires_at.seconds.from_now)
  end
end
