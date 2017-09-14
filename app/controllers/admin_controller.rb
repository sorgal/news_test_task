class AdminController < ApplicationController

  def create
    expires_at = params[:news_record][:expiration_date]
    News::Admin.new().save_admin_news_record(news_record_params, expires_at)
    flash[:notice] = t('.saved')
  rescue
    flash[:error] = t('.error')
    p $!
    Rollbar.error($!)
  ensure
    redirect_to home_index_path
  end

  private

  def news_record_params
    params.require(:news_record).permit(:title, :descr)
  end

end
