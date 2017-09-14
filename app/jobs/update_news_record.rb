class UpdateNewsRecord < Que::Job
  def run()
    News::FromYandex.new().perform_request
  end
end
