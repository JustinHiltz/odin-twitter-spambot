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