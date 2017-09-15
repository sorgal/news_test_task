# frozen_string_literal: true

class News::FromYandex < NewsBase

  attr_accessor :options

  def initialize(options = {})
    @options = options
  end

  def perform
    broadcast(news_record_info)
    store_to_redis(YANDEX_NEWS_KEY, news_record_info.to_a.flatten)
  end

  private

  def yandex_request
    Typhoeus.get(YANDEX_NEWS_URL, options)
  end

  def raw_body
    yandex_request.body.force_encoding('utf-8')
  end

  def data_from_yandex
    JSON.parse("{#{parsed_body}}")
  end

  def parsed_body
    raw_body.scan(/\{(.*?)\}/).flatten.first
  end

  def news_record_info
    @news_record_info ||= data_from_yandex
  end
end
