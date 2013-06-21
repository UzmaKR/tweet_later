class User < ActiveRecord::Base
  has_many :tweets
  def tweet(status)
  	self.tweets << Tweet.create!(:status => status)
  	TweetWorker.perform_async(self.tweets.last.id)
  end
  
end
