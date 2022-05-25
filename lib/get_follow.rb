require 'json'
require 'typhoeus'

module GetFollow
    def get_followers(user_id, results: 100, info: "description,name,username,url", format: "json")
        '''info parameter options (must be a string with the required options): created_at, description, entities,
         id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, withheld
        default info: description,name,username,url'''
        url = "https://api.twitter.com/2/users/#{user_id}/followers"

        info = info.gsub(" ", "")

        params = {
            "max_results" => results,
            "user.fields" => info          
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

    def get_following(user_id, results: 100, info: "description,name,username,url", format: "json")
        '''info parameter options (must be a string with the required options): created_at, description, entities,
         id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, withheld
        default info: description,name,username,url'''
        url = "https://api.twitter.com/2/users/#{user_id}/following"

        info = info.gsub(" ", "")

        params = {
            "max_results" => results,
            "user.fields" => info          
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
end