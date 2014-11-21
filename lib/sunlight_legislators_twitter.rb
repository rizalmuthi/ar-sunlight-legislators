require 'twitter'

class SunlightLegislatorsTwitter
  def self.login
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "YOUR_CONSUMER_KEY"
      config.consumer_secret     = "YOUR_CONSUMER_SECRET"
      config.access_token        = "YOUR_ACCESS_TOKEN"
      config.access_token_secret = "YOUR_ACCESS_SECRET"
    end
  end

  def self.get_last_ten_tweets(legislator_id)
    login
    legislator = Legislator.find(legislator_id)
    timelines = @client.user_timeline(legislator)[0..9]
    timelines.each do |tweet|
      tw = Tweet.new
      tw.text = tweet.text
      tw.tweet_id = tweet.id
      tw.legislator_id = legislator.id
      tw.save
    end
  end
end