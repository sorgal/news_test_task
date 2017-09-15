desc 'Performing news grab'

task start_news_grabber: :environment do
  News::FromYandex.new().perform
end
