module ApplicationHelper
  def news_style
    @news_record.empty? ? 'display: none;' : ''
  end
end
