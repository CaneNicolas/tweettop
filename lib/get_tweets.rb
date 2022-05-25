require 'json'
require 'typhoeus'

module GetTweets
    def get_tweets(tweet_ids, format: "json")#"tweet_ids" must be a string. If more than one ID's are given, they must be comma separated
        url = "https://api.twitter.com/2/tweets"
        tweet_ids = tweet_ids.gsub(" ", "")
        params = {
	        "ids" => tweet_ids,
            "tweet.fields" => "conversation_id,created_at,public_metrics,id,referenced_tweets",
            "media.fields" => "url",
            "user.fields" => "description,username,url",
            "expansions" => "author_id"            
        }

        options = {
            method: 'get',
            headers: {
                "Authorization": "Bearer #{@bearer_token}"
            },
            params: params
        }

        request = Typhoeus::Request.new(url, options)
        response = request.run

        if format == "ruby"
            return JSON.parse(response.body.to_s) 
        elsif format == "code"
            return response.code 
        else
            return JSON.pretty_generate(JSON.parse(response.body))
        end
    end

    def get_conversation(tweet_id, format: "json")#tweet_id must be a single tweet ID
        ids = "#{tweet_id}"
        loop do
            tweet = get_tweets(tweet_id, format: "ruby")
            if is_a_reply(tweet)
                tweet_id = tweet["data"][0]["referenced_tweets"][0]["id"]
                ids += ",#{tweet["data"][0]["referenced_tweets"][0]["id"]}"
            else
                break
            end
        end
        return get_tweets(ids, format: format)
    end

    private

    def is_a_reply(tweet)
        if tweet["data"][0]["referenced_tweets"].class == Array
            return true
        else
            return false
        end
    end
end