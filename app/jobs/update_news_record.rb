class UpdateNewsRecord < Que::Job
  def run
    News::FromYandex.new().perform
  end
end
