require 'oauth'
require 'json'
require 'typhoeus'
require 'oauth/request_proxy/typhoeus_request'

module PostDeleteTweets
    def post_tweet(text)

        url = "https://api.twitter.com/2/tweets"

        @json_payload = {"text": text}

        options = {
	        :method => :post,
	        headers: {
                "content-type": "application/json"
	        },
	        body: JSON.dump(@json_payload)
        }
	    
        access_token = @credentials

        oauth_params = {:consumer => @client, :token => access_token}
        
        request = Typhoeus::Request.new(url, options)
	    oauth_helper = OAuth::Client::Helper.new(request, oauth_params.merge(:request_uri => url))
	    request.options[:headers].merge!({"Authorization" => oauth_helper.header})
	    response = request.run

	    return response.code, JSON.pretty_generate(JSON.parse(response.body))
    end

    def delete_tweet(tweet_id)

        url = "https://api.twitter.com/2/tweets/#{tweet_id}"

        options = {
	        :method => :delete,
	        headers: {
                "content-type": "application/json"
	        }
	    }
	    
        access_token = @credentials

        oauth_params = {:consumer => @client, :token => access_token}
        
        request = Typhoeus::Request.new(url, options)
	    oauth_helper = OAuth::Client::Helper.new(request, oauth_params.merge(:request_uri => url))
	    request.options[:headers].merge!({"Authorization" => oauth_helper.header})
	    response = request.run

        return response.code
    end
end