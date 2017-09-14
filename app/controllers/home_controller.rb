class HomeController < ApplicationController

  def index
    @news_record = News::Output.new().output_news_record
  end

end
