require "typhoeus"
require "json"
require "oauth"
require_relative "get_user_timeline.rb"
require_relative "get_tweets.rb"
require_relative "get_user.rb"
require_relative "get_follow.rb"
require_relative "post_delete_tweets.rb"

module TweetTop
    class User
        include GetUserTimeline
        include GetTweets
        include GetUser
        include GetFollow
        include PostDeleteTweets
    
        def initialize(api_key, api_key_secret, access_token, access_token_secret, bearer_token)
            @api_key = api_key
            @api_key_secret = api_key_secret
            @access_token = access_token
            @access_token_secret = access_token_secret
            @bearer_token = bearer_token
            @client = OAuth::Consumer.new(@api_key, @api_key_secret, :site => 'https://api.twitter.com',
                                                                     :authorize_path => '/oauth/authenticate',
                                                                     :debug_output => false)
            @credentials = OAuth::AccessToken.new(@client, @access_token, @access_token_secret)
        end
    end
end