class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless is_admin?(current_user)
    end

    # Returns a Twitter client
    def twitter()
      begin
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
          config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
          config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
          config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
        end
        return client
      rescue
        # Do nothing if there is a problem with Twitter
      end
    end

    # Returns a given number of tweets from the Twitter client
    # If there is a problem with twitter, like too many requests, return Nil instead
    def tweets(num)
      begin
        return twitter.home_timeline.take(num)
      rescue
        return nil
      end
    end

    # Submits a given string as a tweet
    def tweet(chirp)
      begin
        twitter.update(chirp)
      rescue
        # Do nothing if there is a problem with Twitter
      end
    end

end
