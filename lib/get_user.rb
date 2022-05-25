require 'oauth'
require 'json'
require 'typhoeus'
require 'oauth/request_proxy/typhoeus_request'

module GetUser
    def get_user(usernames, format: "json")

        url = "https://api.twitter.com/2/users/by"

        query_params = {
	        "usernames": usernames,
            "user.fields": "name,description,created_at"
        }

        options = {
	        :method => :get,
	        params: query_params
	    }
	    
        access_token = @credentials

        oauth_params = {:consumer => @client, :token => access_token}
        
        request = Typhoeus::Request.new(url, options)
	    oauth_helper = OAuth::Client::Helper.new(request, oauth_params.merge(:request_uri => url))
	    request.options[:headers].merge!({"Authorization" => oauth_helper.header})
	    response = request.run

	    if format == "ruby"
            return JSON.parse(response.body.to_s) 
        elsif format == "code"
            return response.code 
        else
            return JSON.pretty_generate(JSON.parse(response.body))
        end
    end

    def get_user!(usernames, format: "json")
        
        url = "https://api.twitter.com/2/users/by"
        
        query_params = {
	        "usernames": usernames,
            "user.fields": "name,description,created_at"
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

    def get_user_by_id(user_ids, format: "json")#"user_ids" must be a string. If more than one ID's are given, they must be comma separated
        
        url = "https://api.twitter.com/2/users"
        
        query_params = {
	        "ids": user_ids,
            "user.fields": "name,description,created_at"
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