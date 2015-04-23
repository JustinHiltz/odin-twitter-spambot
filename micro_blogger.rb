require 'jumpstart_auth'

class	MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
  	if message.length > 140
  	  puts "Your tweet will only contain the first 140 characters."
  		message = "".ljust(140, message)
  		@client.update(message)
  	else
  		@client.update(message)
  	end
  end

  def dm(target, message)
  	screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
  	puts "Trying to send #{target} this direct message:"
    puts message
    message = "d @#{target} #{message}"
    if screen_names.include? target 
      tweet(message)
    else 
    	puts "User not following you, cannot dm"
    end
  end

  def followers_list
    screen_names = []
    screen_names << @client.user(follower).screen_name
  end

  def spam_my_followers(message)
    followers_list = @client.followers.collect { |follower| @client.user(follower).screen_name }
    followers_list.each do |follower|
      dm(follower, message)
    end
  end

  # Don't know why this isn't working yet.
  def everyones_last_tweet
    friends = @client.friends
    friends.each do |friend|
      puts friend.screen_name
      # print each friend's screen_name
      # print each friend's last message
      puts ""  # Just print a blank line to separate people
    end
  end
  	

  def run
  	puts "Welcome to the JSL Twitter client!"
  	command = ""
  	while command != "q"
  		printf "enter command: "
  		input = gets.chomp
  		parts = input.split(" ")
  		command = parts[0]
  		case command
  		  when 'q' then puts "Goodbye!"
  		  when 't' then tweet(parts[1..-1].join(" "))
  		  when 'dm' then dm(parts[1], parts[2..-1].join(" "))
  		  when 'spam' then spam_my_followers(parts[1..-1].join(" "))
  		  when 'elt' then everyones_last_tweet
  		  else
  		    puts "I'm sorry I don't know how to #{command}." 
  		end
  	end
  end
end

blogger = MicroBlogger.new
# blogger.tweet_length("This one is another test Tweet.")
# blogger.tweet_length("This is me testing that this message which contains more than 140 characters will not, indeed, post to the Twitter account. What will happen?")

blogger.run