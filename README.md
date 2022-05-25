# TweetTop

WHAT IS TWEETTOP?

TweetTop is a simplistic API wrapper to keep track of Twitter 
accounts and conversations.
With TweetTop you can search for tweets, conversations and get the 
important data of these, such as metrics (likes, retweets, etc.), 
their author's info, a reference to the conversation these tweet 
are involved in, etc.
TweetTop also lets you look up for users information, their timelines, and 
followers.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add tweettop

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install tweettop
## Usage/Examples

First of all you have to include the gem into your project: 
```ruby
require "tweettop"
```
Once you've done this, the next step is to initialize an instance
of TweetTop with your Twitter API keys and tokens (wich you can 
get on https://developer.twitter.com/) as parameters and asign it 
to a variable:
```ruby
user = TweetTop::User.new(api_key,api_key_secret,access_token,
                          access_token_secret,bearer_token)
```
Now, with your user set up, you can start using all the methods
TweetTop provides you with.

For example:
```ruby
#searching for TwitterDev account info
user.get_user("TwitterDev", format: "json")

#returns
{
  "data": [
    {
      "description": "The voice of the #TwitterDev team and your 
                      official source for updates, news, and
                      events, related to the #TwitterAPI.",
      "username": "TwitterDev",
      "id": "2244994945",
      "created_at": "2013-12-14T04:35:55.000Z",
      "name": "Twitter Dev"
    }
  ]
}
```
You can also require the data to be given in a Hash by changing the
value of the format parameter to "ruby":
```ruby
user.get_user("TwitterDev", format: "ruby")

#returns
{"data"=>[{"created_at"=>"2013-12-14T04:35:55.000Z", 
"name"=>"Twitter Dev", "id"=>"2244994945", "username"=>"TwitterDev",
"description"=>"The voice of the #TwitterDev team and your official
source for updates, news, and events, related to the #TwitterAPI."}]}
```
Now that you know the TwitterDev account ID, you can look-up for
this account timeline:
```ruby
user.get_user_timeline("2244994945", results: "5", format: "json")

#returns (for this example we'll only show one of the 5 tweets we required)
{
  "data": [
    {
      "referenced_tweets": [
        {
          "type": "replied_to",
          "id": "1529160434934198272"
        }
      ],
      "text": "Jerry Yang, one of @taaf's founding board members, 
              joined us to talk about his life experience that led 
              him to start TAAF and create the Decoding Hate project
              in this premiere article of the Global Scope series. Read
              the interview here. 
              #IAmATwitterDev\nhttps://t.co/6XjDE6RkOH https://t.co/XqlNWW0o3q",
      "created_at": "2022-05-24T18:00:33.000Z",
      "id": "1529160439291969536",
      "conversation_id": "1529160427665379328",
      "public_metrics": {
        "retweet_count": 1,
        "reply_count": 0,
        "like_count": 6,
        "quote_count": 0
      }
    }, ...
```
You know now that this last tweet is a response to another tweet,
and you know that tweet ID.

Therefore you can get that single tweet:
```ruby
user.get_tweets("1529160434934198272", format: "json")

#returns
{
  "data": [
    {
      "text": "Using the Twitter API v2 search Tweets and Tweets
              lookup endpoints, the team turned thousands of Tweets 
              into insightful stories.\n\nLearn more about the
              technical aspectsof Decoding Hate and the impact 
              it's had.
              \nhttps://t.co/EHp3Ao529N https://t.co/JHSRNmlAb7",
      "referenced_tweets": [
        {
          "type": "replied_to",
          "id": "1529160430127435776"
        }
      ],
      "created_at": "2022-05-24T18:00:32.000Z",
      "conversation_id": "1529160427665379328",
      "author_id": "2244994945",
      "id": "1529160434934198272",
      "public_metrics": {
        "retweet_count": 1,
        "reply_count": 1,
        "like_count": 9,
        "quote_count": 0
      }
    }
  ], ...
```
Or you can look-up for the tweet this last tweet refers to and so on,
getting the conversation the originaly searched tweet is involved in:
```ruby
#this method will return all the tweets involved in the conversation,
#either quoted, responded or retweeted
user.get_conversation("1529160439291969536", format: "json")
```
Every method can return three types of data dependingon what
you specify on the methods' "format" parameter ("json", "ruby" or "code"):
  - A string that gives you a JSON-like view of the data,
  - a hash with the data, wich makes the information accesible to
    its use,
  - and an integer, the code that of the request's result
    (for testing purposes).
## Contributing

Contributions are always welcome!

Bug reports and pull requests are welcome on GitHub
at https://github.com/CaneNicolas/tweettop.


## Running Tests

To run tests, run the "tweettop_test.rb" file 
within the "test"folder of the respository.
