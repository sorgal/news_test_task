class HomeController < ApplicationController

  def index
    redis = Redis.current
    @news_record = redis.hgetall(NewsProcessor::ADMIN_NEWS_KEY)
    @news_record = redis.hgetall(NewsProcessor::YANDEX_NEWS_KEY) if @news_record.empty?
  end

end
