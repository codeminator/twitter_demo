class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  #controller concern for exceptions handling
  include ExceptionHandler

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def client
  	@client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = current_user.oauth_token
      config.access_token_secret = current_user.oauth_secret
    end
  end

end
