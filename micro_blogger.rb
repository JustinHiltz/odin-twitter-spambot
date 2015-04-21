require 'jumpstart_auth'

class	MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
  	@client.update(message)
  end

  def tweet_length(message)
  	if message.length > 140
  		puts "Your tweet will only contain the first 140 characters."
  		message = "".ljust(140, message)
  		tweet(message)
  	else
  		tweet(message)
  	end
  end
end

blogger = MicroBlogger.new
blogger.tweet_length("This one is another test Tweet.")
blogger.tweet_length("This is me testing that this message which contains more than 140 characters will not, indeed, post to the Twitter account. What will happen?")
# Error message from the Twitter API