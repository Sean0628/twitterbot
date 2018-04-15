namespace :twitter do
  desc "Tweet a famous quotes every 30 mins"
  task :tweet do
    define_client
    tweet  = Quote.where( 'id >= ?',
                                rand(Quote.first.id..Quote.last.id) ).first
    post   = "#{tweet.body}\n-#{tweet.author}-"
    @client.update(post)
  end
end

private
def define_client
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["CONSUMER_KEY"]
    config.consumer_secret     = ENV["CONSUMER_SECRET"]
    config.access_token        = ENV["ACCESS_TOKEN"]
    config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  end
end
