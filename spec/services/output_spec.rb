require "rails_helper"

RSpec.describe News::Output  do
  let(:redis) { Redis.current }
  let(:yandex_data) { { title: 'Test title yandex', descr: 'Test descr yandex' } }
  let(:data) { { title: 'Test title', descr: 'Test descr' } }

  before(:each) do
    clean
    redis.hmset(NewsBase::YANDEX_NEWS_KEY, yandex_data.to_a.flatten)
  end

  after(:each) do
    clean
  end

  context 'news record fetch' do
    it 'checks yandex news record fetch works correctly' do
      check_response(yandex_data)
    end

    it 'checks admin news record fetch works correctly' do
      redis.hmset(NewsBase::ADMIN_NEWS_KEY, data.to_a.flatten)
      check_response(data)
    end
  end

end
