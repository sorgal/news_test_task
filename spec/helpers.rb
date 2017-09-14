module Helpers
  def clean
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE que_jobs")
    Redis.current.flushdb
  end
end
