
prompt = TTY::Prompt.new

def welcome
    prompt = TTY::Prompt.new
    q = prompt.select("Hello! Do you have a user name?", %w(Yes No)) 
    if q == "Yes"
        prompt.ok("Please enter your user name.")
        @this_user_name = gets.chomp
        if !User.exists?(userName: @this_user_name)
            prompt.error("User not found, please try again or create a new user.")
            welcome
        else
            $user = User.find_by(userName: @this_user_name)
            prompt.ok("Thanks, #{@this_user_name}!")
        end
    elsif q == "No"
        prompt.ok("Let's create a user name!")
        create_new_user
    end
    main_menu  
end

def main_menu
    prompt = TTY::Prompt.new
    choices = ['Purchase a ticket', 'Cancel a ticket', 'Update user name', 'Share event info via text', 'See my tickets', 'Exit program']
    response = prompt.select("What would you like to do now?", choices, cycle: true)
        if response == "Purchase a ticket"
            buy_ticket
        elsif response == "Cancel a ticket"
            cancel_ticket
        elsif response == "See my tickets"
            tickets = []
            tickets = Ticket.all.where(userName: @this_user_name)
            if tickets.length == 0
                prompt.error("You don't have any tickets.")
                main_menu
            else
                ticketNames = []
                tickets.all.each do |stuff|
                    ticketNames << stuff.ticketName.tr('[]"', "")
                end
                prompt.ok(ticketNames)
                main_menu
            end
        elsif response == "Update user name"
            update_user_name
        elsif response == "Share event info via text"
            text_info
        elsif response == "Exit program"
            prompt.warn("Goodbye!👋")
            exit!
        else
            prompt.error("I'm sorry, I'm a computer and I don't understand ¯\_(ツ)_/¯")
        end
    main_menu
end

def create_new_user
    prompt = TTY::Prompt.new
    prompt.ok("What would you like your user name to be?")
    @this_user_name = gets.chomp
    $user  = User.create({ userName: @this_user_name }) 
    if $user.id == nil
        prompt.error($user.errors.full_messages)
        create_new_user
    else
        prompt.ok("OK, your user name is #{$user.userName}.")
    end
end

def update_user_name
    prompt = TTY::Prompt.new
    prompt.ok("What would you like your new user name to be?")
    new_user_name = gets.chomp
    
    $user.update(userName: new_user_name)
    Ticket.where(userName: @this_user_name).update_all(userName: new_user_name)
    Venue.where(userName: @this_user_name).update_all(userName: new_user_name)
    @this_user_name = new_user_name

    prompt.ok("OK, your new user name is #{new_user_name}.")
    main_menu
end

def buy_ticket
    prompt = TTY::Prompt.new
    choices = ['See events by zip code', 'See events by venue name', 'See events by category', 'See events by date range']
    response = prompt.select("How would you like to select a ticket?", choices, cycle: true)
        if response == "See events by zip code"
            prompt.warn("Choose a zip code.")
            this_zip = gets.strip
            #this_zip.validate /\A\d{3}\Z/
            find_events_by_zip_code(this_zip)
        elsif response == "See events by venue name"
            prompt.warn("Choose a venue.")
            event_venue = gets.strip
            find_events_by_venue(event_venue)
        elsif response == "See events by category"
            event_category = prompt.select("Choose an event type", ["Music", "Sports", "Miscellaneous"]) 
            # event_category = gets.strip
            prompt.warn("Choose a city")
            event_city = gets.strip
            find_events_by_type(event_category, event_city)
        elsif response == "See events by date range"
            prompt.warn("Choose a city")
            event_city = gets.strip
            this_start_date = prompt.ask("Choose a beginning date (example: January 1, 2020)", convert: :datetime).strftime('%FT%T')
            this_end_date = prompt.ask("Choose an ending date (example: January 1, 2020)", convert: :datetime).strftime('%FT%T')
            find_events_by_date(this_start_date, this_end_date, event_city)
        else
            prompt.error("I'm sorry, I'm a computer and I don't understand ¯\_(ツ)_/¯")
        end
end

def cancel_ticket
    prompt = TTY::Prompt.new
    choices = []
    choices = Ticket.all.where(userName: @this_user_name)
    if choices.length == 0
        prompt.error("You don't have any tickets.")
        main_menu
    else
        ticketNames = []
        choices.all.each do |stuff|
            ticketNames << stuff.ticketName
    end
        userResponse = prompt.select("Which ticket would you like to cancel?", ticketNames, cycle: true)
        ticket_to_destroy = Ticket.find_by(ticketName: userResponse, userName: @this_user_name)
        venue_to_destroy = Venue.find_by(ticketName: userResponse, userName: @this_user_name)
        ticket_to_destroy.destroy
        venue_to_destroy.destroy
        prompt.error("Ticket has been deleted.")
        main_menu
    end
end

def text_info
    
    prompt = TTY::Prompt.new
    choices = []
    choices = Ticket.all.where(userName: @this_user_name)
    if choices.length == 0
        prompt.error("You don't have any tickets.")
        main_menu
    else
        ticketNames = []
        choices.all.each do |stuff|
            ticketNames << stuff.ticketName
    end
        userResponse = prompt.select("Which ticket would you like to text?", ticketNames, cycle: true)
        ticket_to_send = Ticket.find_by(ticketName: userResponse, userName: @this_user_name)


        client = Twilio::REST::Client.new(@account_sid, @auth_token)

        from = '+18329570528' # Your Twilio number
        to = '+18327219007' # Your mobile phone number

        client.messages.create(from: from, to: to, body: ticket_to_send.ticketName)
        
        prompt.warn("Ticket has been sent.")
        main_menu
    end
end