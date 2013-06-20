class TweetWorker
  include Sidekiq::Worker 

  def perform(tweet_id)
  	tweet = Tweet.find(tweet_id)
  	user = tweet.user

  	#set up Twitter oauth client here
  	p user.oauth_token
  	p user.oauth_secret

  	client = Twitter::Client.new(
  		oauth_token: user.oauth_token,
  		oauth_token_secret: user.oauth_secret)
  	p client.consumer_key
  	p client.consumer_secret
  	client.update(tweet.status)
  	#actually make API call
  	#Note: this does not have access to controller,view
  	#helpers
  	#You'll have to re-initialize everything inside here



  end
end
