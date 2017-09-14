class NewsRoot
  # frozen_string_literal: true
  YANDEX_NEWS_URL = 'https://news.yandex.ru/index5.utf8.js'
  YANDEX_NEWS_KEY = 'from_yandex'
  ADMIN_NEWS_KEY = 'from_admin'

  private

  def redis
    @redis ||= Redis.current
  end

  def store_to_redis(key, data)
    redis.hmset(key, data)
  end

  def broadcast(data)
    return if Rails.env.test?
    ActionCable.server.broadcast 'news', data
  end
end
