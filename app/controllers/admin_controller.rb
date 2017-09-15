# frozen_string_literal: true

class AdminController < ApplicationController

  def create
    News::Admin.new().save_admin_news_record(news_record_params)
    flash[:notice] = t('.saved')
  rescue
    flash[:error] = t('.error')
    Rollbar.error($!)
  ensure
    redirect_to home_index_path
  end

  private

  def news_record_params
    params.require(:news_record).permit(:title, :descr, :expiration_date)
  end

end
