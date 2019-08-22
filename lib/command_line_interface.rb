
prompt = TTY::Prompt.new

# @user = Object.new

def welcome
    prompt = TTY::Prompt.new
    q = prompt.select("Hello! Do you have a user name?", %w(Yes No)) 
    if q == "Yes"
        puts "Please enter your user name."
        @this_user_name = gets.chomp
        $user = User.find_by(userName: @this_user_name)
        puts "Thanks, #{@this_user_name}!"
    else 
        puts "Let's create a user name!"
        create_new_user
    end
    main_menu  
end

def main_menu
    prompt = TTY::Prompt.new
    choices = ['Purchase a ticket', 'Cancel a ticket', 'Update user name', 'Exit program']
    response = prompt.select("What would you like to do now?", choices, cycle: true)
        if response == "Purchase a ticket"
            buy_ticket
        elsif response == "Cancel a ticket"
            cancel_ticket
        elsif response == "Update user name"
            update_user_name
        elsif response == "Exit program"
            puts "Goodbye!👋"
            exit!
        else
            puts "I'm sorry, I'm a computer and I don't understand ¯\_(ツ)_/¯"
        end
    main_menu
end

def create_new_user
    prompt = TTY::Prompt.new
    puts "What would you like your user name to be?"
    @this_user_name = gets.chomp
    $user  = User.create({ userName: @this_user_name }) 
  
    puts "OK, your user name is #{$user.userName}."
end

def update_user_name
    # LIKE THIS:
    # user = User.find_by(name: 'David')
    # user.update(name: 'Dave')
    
    puts "What would you like your new user name to be?"
    new_user_name = gets.chomp
    

    # @user = User.find_by(userName: new_user_name)
    $user.update(userName: new_user_name)
    Ticket.where(userName: @this_user_name).update_all(userName: new_user_name)
    Venue.where(userName: @this_user_name).update_all(userName: new_user_name)
    @this_user_name = new_user_name

    puts "OK, your new user name is #{new_user_name}."
    main_menu
end

def buy_ticket
    prompt = TTY::Prompt.new
    choices = ['See events by zip code', 'See events by venue name', 'See events by category', 'See events by date range']
    response = prompt.select("How would you like to select a ticket?", choices, cycle: true)
        if response == "See events by zip code"
            puts "Choose a zip code."
            this_zip = gets.strip
            #this_zip.validate /\A\d{3}\Z/
            find_events_by_zip_code(this_zip)
        elsif response == "See events by venue name"
            puts "Choose a venue."
            event_venue = gets.strip
            find_events_by_venue(event_venue)
        elsif response == "See events by category"
            event_category = prompt.select("Choose an event type", ["Music", "Sports", "Miscellaneous"]) 
            # event_category = gets.strip
            puts "Choose a city"
            event_city = gets.strip
            find_events_by_type(event_category, event_city)
        elsif response == "See events by date range"
            puts "Choose a city"
            event_city = gets.strip
            this_start_date = prompt.ask("Choose a beginning date (example: January 1, 2020)", convert: :datetime).strftime('%FT%T')
            this_end_date = prompt.ask("Choose an ending date (example: January 1, 2020)", convert: :datetime).strftime('%FT%T')
            find_events_by_date(this_start_date, this_end_date, event_city)
        else
            puts "I'm sorry, I'm a computer and I don't understand ¯\_(ツ)_/¯"
        end
end

def cancel_ticket
    # LIKE THIS:
    # user = User.find_by(name: 'David')
    # user.destroy
    prompt = TTY::Prompt.new
    choices = []
    choices = Ticket.all.where(userName: @this_user_name)
    if choices.length == 0
        puts "You don't have any tickets."
        main_menu
    else
        ticketNames = []
        choices.all.each do |stuff|
            ticketNames << stuff.ticketName
    end
        userResponse = prompt.select("Which ticket would you like to cancel?", ticketNames, cycle: true)
        ticket_to_destroy = Ticket.find_by(ticketName: userResponse, userName: @this_user_name)
        ticket_to_destroy.destroy
        main_menu
    end
end