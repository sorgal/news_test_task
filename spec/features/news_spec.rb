require "rails_helper"

feature 'News' do
  let(:redis) { Redis.current }
  let(:data) { { title: 'Test title', descr: 'Test descr' } }

  before(:each) do
    clean
  end

  after(:each) do
    clean
  end

  scenario 'shows nothing when redis is empty', js: true do
    visit home_index_path
    expect(page).to have_selector('#news', visible: false)
  end

  scenario 'shows actual news record', js: true do
    redis.hmset(NewsBase::ADMIN_NEWS_KEY, data.to_a.flatten)
    visit home_index_path
    expect(page).to have_selector('#news', visible: true)
    expect(page).to have_selector('#news_title', text: /#{data[:title]}/i)
    expect(page).to have_selector('#news_description', text: /#{data[:descr]}/i)
  end

  scenario 'shows actual news record broadcast', js: true do
    visit home_index_path
    expect(page).to have_selector('#news', visible: false)
    ActionCable.server.broadcast 'news', title: data[:title],
                                         descr: data[:descr]
    expect(page).to have_selector('#news', visible: true)
    expect(page).to have_selector('#news_title', text: /#{data[:title]}/i)
    expect(page).to have_selector('#news_description', text: /#{data[:descr]}/i)
  end

end
