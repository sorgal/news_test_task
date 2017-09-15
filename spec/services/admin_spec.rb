require "rails_helper"

RSpec.describe News::Admin  do
  let(:redis) { Redis.current }
  let(:expire) { (DateTime.now + 3.minutes).strftime('%Y-%m-%dT%H:%M') }
  let(:data) { { title: 'Test title', descr: 'Test descr', expiration_date: expire } }

  before(:each) do
    clean
  end

  after(:each) do
    clean
  end

  context 'admin news record' do
    it 'checks admin news record save works correctly' do
      check_date = Time.now
      expect { News::Admin.new().save_admin_news_record(data) }
      .to change { ActiveRecord::Base.connection.execute("SELECT * FROM que_jobs").count }
      .from(0).to(1)
      expect(redis.ttl(NewsBase::ADMIN_NEWS_KEY) <= 3.minutes.to_i).to eq(true)
      record = redis.hgetall(NewsBase::ADMIN_NEWS_KEY)
      expect(record['title']).to eq(data[:title])
      expect(record['descr']).to eq(data[:descr])
      expect(record['date']).to eq(check_date.strftime('%d.%m.%Y'))
      expect(record['time']).to eq(check_date.strftime('%H:%M'))
    end
  end

end
