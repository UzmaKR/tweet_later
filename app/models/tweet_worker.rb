class TweetWorker
  include Sidekiq::Worker 

  def perform(tweet_id)
  	tweet = Tweet.find(tweet_id)
    p "#{tweet.inspect} in TweetWorker#perform"
  	user = User.find(tweet.user_id)
    p "#{user.inspect} in TweetWorker#perform"

  	#set up Twitter oauth client here

  	client = Twitter::Client.new(
  		oauth_token: user.oauth_token,
  		oauth_token_secret: user.oauth_secret)
  	
    sleep(rand(10))

  	client.update(tweet.status)
  	#actually make API call
  	#Note: this does not have access to cont roller,view
  	#helpers
  	#You'll have to re-initialize everything inside here
  end
end
