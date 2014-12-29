class UserController < ApplicationController

  def my_tweets
	  @tweets = current_user.my_tweets
  end

  def friends_timeline
    @tweets = current_user.home_timeline
    @is_followed = true
  end

  def friends
    @friends = current_user.followers
  end

  def single_timeline
    begin
      @tweets = current_user.user_timeline(@username = user_params[:username])
      @user = client.user(@username)
      @is_followed = current_user.following?(@user)
    rescue Twitter::Error::NotFound
      flash[:error] = t('app.messages.errors.user_not_found', username: @username)
      redirect_to my_tweets_user_path
		end
  end

  def follow
    begin
      current_user.follow(username = user_params[:username])
    rescue Twitter::Error::NotFound
      flash[:error] = t('app.messages.errors.user_not_found', username: username)
    end
    redirect_to friends_timeline_user_path, notice: t('app.messages.followed', username: username)
  end

  def unfollow
    current_user.unfollow(username = user_params[:username])
    redirect_to friends_timeline_user_path, notice: t('app.messages.unfollowed', username: username)
  end

  def tweet
    current_user.tweet(user_params[:tweet])
    redirect_to my_tweets_user_path, notice: t('app.messages.success_tweet')
  end

  def message
    current_user.message(username = user_params[:username], user_params[:body])
    redirect_to friends_timeline_user_path, notice: t('app.messages.sent', username: username)
  end

  private

  def user_params
    params.permit(:username, :body, :tweet)
  end
end
