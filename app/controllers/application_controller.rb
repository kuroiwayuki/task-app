class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    return unless session[:user_id]

    Current.user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    return unless Current.user.nil?

    flash[:notice] = 'ログインが必要です'
    redirect_to('/')
  end
end
