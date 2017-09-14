class NewsProcessor
  # frozen_string_literal: true
  YANDEX_NEWS_URL = 'https://news.yandex.ru/index5.utf8.js'
  YANDEX_NEWS_KEY = 'from_yandex'
  ADMIN_NEWS_KEY = 'from_admin'

  def perform_request
    news_info = JSON.parse(Typhoeus.get(YANDEX_NEWS_URL).body.force_encoding('utf-8')
                                   .scan(/var m_index = (.+); var/).flatten.first)
                                   .first.to_a.flatten
    store_to_redis(YANDEX_NEWS_KEY, news_info)
  end

  def save_admin_news_record(params, expire)
    now = Time.now
    expires_at = (Time.parse(expire) - now).round
    date, time = now.strftime('%d.%m.%Y %H:%M').split(' ')
    publish_date_time = { 'date' => date, 'time' => time }
    news_record_data = params.merge!(publish_date_time).to_h.to_a.flatten
    store_to_redis(ADMIN_NEWS_KEY, news_record_data)
    redis.expire(ADMIN_NEWS_KEY, expires_at)
  end

  private

  def redis
    @redis ||= Redis.current
  end

  def store_to_redis(key, data)
    redis.hmset(key, data)
  end
end
