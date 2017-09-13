desc 'Performing news grab'

task start_news_grabber: :environment do
  NewsGrabber.new().perform_request
end
