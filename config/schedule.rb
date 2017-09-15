set :output, "log/cron_log.log"
env :PATH, ENV['PATH']

every 5.minutes do
  rake 'start_news_grabber'
end
