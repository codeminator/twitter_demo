module Twitterable
  extend ActiveSupport::Concern

  module ClassMethods
    def flush_client
      @@client = nil
    end
  end

  def client
    @@client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = self.oauth_token
      config.access_token_secret = self.oauth_secret
    end
  end

  def user_instance
    @user ||= client.user
  end

  def my_tweets
    def collect_with_max_id(options = {})
      max_id = options[:max_id]
      collection = options[:collection] || []
      no_recursion = options[:no_recursion]
      response = yield(max_id)
      collection += response
      (response.empty? || no_recursion) ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
    end

    collect_with_max_id({no_recursion: true}) do |max_id|
      options = {count: 20, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      client.user_timeline(self, options)
    end
  end

  def home_timeline
    client.home_timeline
  end

  def followers
    client.followers
  end

  def user_timeline(username)
    client.user_timeline(username)
  end

  def tweet(message)
    client.update(message)
  end

  def follow(username)
    client.follow(username)
  end

  def unfollow(username)
    client.unfollow(username)
  end

  def following?(username)
    client.user(username, {include_entities: false}).following?
  end

  def block(username)
    client.block(username)
  end

  def unblock(username)
    client.unblock(username)
  end

  def search
  end

  def message(username, body)
    client.create_direct_message(username, body)
  end

  def statuses_count
    user_instance.statuses_count
  end

  def friends_count
    user_instance.friends_count
  end

  def followers_count
    user_instance.followers_count
  end

  def favorites_count
    user_instance.favorites_count
  end
end