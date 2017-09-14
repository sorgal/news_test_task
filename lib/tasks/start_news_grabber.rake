desc 'Performing news grab'

task start_news_grabber: :environment do
  NewsProcessor.new().perform_request
end
