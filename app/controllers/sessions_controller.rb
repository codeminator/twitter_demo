class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to my_tweets_user_path, notice: 'Signed in sucessfully'
  end
 
  def destroy
    reset_session
    User.flush_client
    redirect_to root_path
  end

  def error
    flash[:error] = 'Sign in to Twitter failed'
    redirect_to root_path
  end
end
