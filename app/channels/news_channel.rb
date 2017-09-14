class NewsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'news'
  end
end
