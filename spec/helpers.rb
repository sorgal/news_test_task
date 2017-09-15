module Helpers
  def clean
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE que_jobs")
    Redis.current.flushdb
  end

  def check_response(expected_response)
    record = News::Output.new().output_news_record
    expect(record['title']).to eq(expected_response[:title])
    expect(record['descr']).to eq(expected_response[:descr])
  end
end
