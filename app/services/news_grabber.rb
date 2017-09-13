class NewsGrabber
  # frozen_string_literal: true
  
  YANDEX_NEWS_URL = 'https://news.yandex.ru/index5.utf8.js'
  YANDEX_NEWS_KEY = 'from_yandex'
  ADMIN_NEWS_KEY = 'from_admin'

  def perform_request
    return unless redis.hgetall(ADMIN_NEWS_KEY).empty?
    news_info = JSON.parse(Typhoeus.get(YANDEX_NEWS_URL).body.force_encoding('utf-8')
                                   .scan(/var m_index = (.+); var/).flatten.first)
                                   .first.to_a.flatten
    redis.hmset(YANDEX_NEWS_KEY, news_info)
  end

  private

  def redis
    @redis ||= Redis.current
  end
end
