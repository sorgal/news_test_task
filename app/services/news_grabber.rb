class NewsGrabber
  YANDEX_NEWS_URL = 'https://news.yandex.ru/index5.utf8.js'.freeze

  def self.perform_request
    news = Typhoeus.get(YANDEX_NEWS_URL).body.force_encoding('utf-8')
    main_record = JSON.parse(news.scan(/var m_index = (.+); var/).flatten.first).first
    New.create!(title: main_record['title'],
                date: DateTime.parse("#{main_record['date']} #{main_record['time']}").to_s(:db),
                text: main_record['descr'])
  end
end
