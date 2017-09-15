require "rails_helper"

RSpec.describe News::FromYandex  do
  let(:redis) { Redis.current }
  let(:yandex_response) { { title: 'Test title', descr: 'Test descr' } }

  before(:each) do
    clean
    stub_request(:get, NewsBase::YANDEX_NEWS_URL)
    .with(headers: {'Expect'=>'',
                    'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'})
    .to_return(status: 200, body: yandex_response.to_json)
  end

  after(:each) do
    clean
  end

  context 'yandex news record' do
    it 'checks yandex news record save works correctly' do
      News::FromYandex.new().perform
      record = redis.hgetall(NewsBase::YANDEX_NEWS_KEY)
      expect(record['title']).to eq(yandex_response[:title])
      expect(record['descr']).to eq(yandex_response[:descr])
    end
  end

end
