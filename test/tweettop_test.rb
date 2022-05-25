require "/home/nicolas/tweettop/lib/tweettop.rb"
require 'minitest/autorun'

class TweetTopTest < Minitest::Test

  include TweetTop
  def user_test
    api_key = "dnzrlRGVAdK0YfrzVO7DRjTFk"
    api_key_secret = "knowHzZUDPeZy6nJQTxFfMnMUWyCGhlQuWYCJsqyGDxyfwfScN"
    access_token = "355644761-zV99nKyCc3YqYsDlGxWZKB5r1eHQhwHx3egF5A93"
    access_token_secret = "eXqD0UZEcRJXEoO4Jx1rOp9S07a9W03FpxVeBnQjk9qtt"
    bearer_token = "AAAAAAAAAAAAAAAAAAAAAEf1cgEAAAAAsN%2FMfLgehZi13qg22b5%2BWBQh2m4%3D8OUASOdYy3EbMgcIvMPVMESeojWVewZGkbHVyIS2gEKemqPY07"
    return TweetTop::User.new(api_key,api_key_secret,access_token,access_token_secret,bearer_token)
  end

  def test_get_followers
    assert_equal 200,
      user_test.get_followers("2244994945", format: "code")
  end

  def test_get_following
    assert_equal 200,
      user_test.get_following("2244994945", format: "code")
  end

  def test_get_user_timeline
    assert_equal 200,
      user_test.get_user_timeline("2244994945", format: "code")
  end

  def test_get_user
    assert_equal 200,
      user_test.get_user("TwitterDev", format: "code")
  end

  def test_get_user!
    assert_equal 200,
      user_test.get_user!("2244994945", format: "code")
  end

  def test_get_user_by_id
    assert_equal 200,
      user_test.get_user_by_id("2244994945", format: "code")
  end

  def test_get_tweets
    assert_equal 200,
      user_test.get_tweets("1527691246449225728", format: "code")
  end

  def test_get_conversation
    assert_equal 200,
      user_test.get_conversation("1529285461788594178", format: "code")
  end
end