# frozen_string_literal: true

class News::Admin < NewsBase

  def save_admin_news_record(params)
    data = news_record_data(params)
    store_to_redis(ADMIN_NEWS_KEY, data.to_a.flatten)
    broadcast(data)
    make_expiration_at(params[:expiration_date])
  end

  private

  def get_expiration_for(date)
    (Time.strptime(date, '%Y-%m-%dT%H:%M') - now).round
  end

  def news_record_data(data)
    date, time = now.strftime('%d.%m.%Y %H:%M').split(' ')
    publish_date_time = { 'date' => date, 'time' => time }
    data.merge!(publish_date_time).to_h
  end

  def make_expiration_at(date)
    expires_at = get_expiration_for(date)
    redis.expire(ADMIN_NEWS_KEY, expires_at)
    UpdateNewsRecord.enqueue(run_at: expires_at.seconds.from_now)
  end

  def now
    @now ||= Time.now
  end
end
