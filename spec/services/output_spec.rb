require "rails_helper"

RSpec.describe News::Output  do
  let(:redis) { Redis.current }
  let(:yandex_data) { { 'title' => 'Test title yandex', 'descr' => 'Test descr yandex' } }
  let(:data) { { 'title' => 'Test title', 'descr' => 'Test descr' } }

  before(:each) do
    clean
    redis.hmset(NewsRoot::YANDEX_NEWS_KEY, yandex_data.to_a.flatten)
  end

  after(:each) do
    clean
  end

  context 'news record fetch' do
    it 'checks yandex news record fetch works correctly' do
      expect(News::Output.new().output_news_record).to eq(yandex_data)
      # expect(record['title']).to eq(yandex_response[:title])
      # expect(record['descr']).to eq(yandex_response[:descr])
    end

    it 'checks admin news record fetch works correctly' do
      redis.hmset(NewsRoot::ADMIN_NEWS_KEY, data.to_a.flatten)
      expect(News::Output.new().output_news_record).to eq(data)
      # expect(record['title']).to eq(yandex_response[:title])
      # expect(record['descr']).to eq(yandex_response[:descr])
    end
  end

end
