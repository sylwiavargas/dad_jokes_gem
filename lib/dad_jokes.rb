class DadJokes
 
  def joke
    get_joke(what_subject)
  end

  private

  def what_subject
    # save the response
    puts "What do you want your joke to be about?"
    sleep(0.5)
    puts "Write 'random' if you want to be surprised"
    joke_subject = gets.chomp.downcase
  end

  def get_joke(subject)
    # save url to a variable
    url = "https://icanhazdadjoke.com/"
    # if user's response was random, just use the url, if not, concatenate
    if subject == "random"
      search_jokes(url)
    else
      search_jokes(url+"search?term=#{subject}")
    end
  end

  def search_jokes(url)
    # here is a curl-to-ruby convertor I found: https://jhawthorn.github.io/curl-to-ruby/
    ##### YOU DON'T NEED TO KNOW WHAT EACH LINE DOES BUT JUST IN CASE I'M ADDING EXPLANATIONS #####
    # parse the URL
    uri = URI.parse(url)
    # save the request to a variable
    request = Net::HTTP::Get.new(uri)
    # set an accept header to text/plain
    request["Accept"] = "text/plain"
    # set options to a hash with the ssl key
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    # now, parse the response to our request
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    # at this point, I wanted to see what I was getting, so naturally:
    # binding.pry

    # now I learned that the response I am getting is a string -- let's make it an array!
    jokes = response.body.split(/(?<!\r)\n/)
    # I will want to output only one joke out of the array, let's sample it:
    joke = jokes.sample.to_s.force_encoding("UTF-8")
    # I'm adding encoding because I got errors that indicated I needed this.

    # now, if the user wrote some gibberish or there's no record, put a message and if there is, show the joke:
    if jokes == nil || jokes.length == 0 #see what happens if you put nil on the right!
      puts "Sorry! No jokes about it"
    else
      system 'clear'
      puts "There are #{jokes.length} on this subject!"
      # let's add some color and embold it <- it comes with colorize!
      choose_color(joke)
      # colorize(:color => :red, :background => :cyan).bold
    end
    sleep(0.5)
    # then ask the User if they want to save they joke to their favs
    another_one?
  end

  def choose_color(joke)
      font_color = ["red", "blue", "black"].sample.to_sym
      background_color = ["light_cyan", "light_white", "light_green", "light_magenta", "light_yellow", "cyan"].sample.to_sym
      puts joke.colorize(:color => font_color, :background => background_color)
  end

  def another_one?
    # set up an array with prompts so it doesn't get repetitive
    prompts = ["Wanna hear another one?", "Wanna one more?", "Wanna more laughs?"]
    # sample a prompt
    puts prompts.sample
    # helper method to determine what's next
    next_steps
  end

  def next_steps
    # save user's response
    answer = gets.chomp
    # if yes,
    if answer == "yes"
      get_joke(what_subject)
    elsif answer == "no"
      # say bye bye
      puts "goodbye!"
      system 'exit'
    else
      puts "Say 'yes' or 'no'"
      # recursion -- the method is calling on itself
      next_steps
    end
  end

end
