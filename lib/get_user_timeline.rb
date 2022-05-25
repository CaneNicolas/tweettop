require 'json'
require 'typhoeus'

module GetUserTimeline
    def get_user_timeline(user_id, results = 5, format: "json") #results: minimum 5, maximum 200
        
        url = "https://api.twitter.com/2/users/#{user_id}/tweets"
        
        query_params = {
            "max_results" => results,
            "tweet.fields" => "conversation_id,created_at,public_metrics,id,referenced_tweets",
            "user.fields" => "description,username,url",
            "media.fields" => "url" 
        }

        options = {
            method: 'get',
            headers: {
              "Authorization" => "Bearer #{@bearer_token}"
              },
            params: query_params
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
end