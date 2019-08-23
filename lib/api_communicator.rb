def find_events_by_zip_code(zip_code)
    prompt = TTY::Prompt.new
    events_results_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=@apiKey&postalCode=#{zip_code}")
    events_results_hash = JSON.parse(events_results_string)
    
    if events_results_hash["_embedded"] == nil
        prompt.error("No events found")
        main_menu
    else

        eventNameArray = events_results_hash["_embedded"]["events"].map
        nameHash = {}
        nameArray = []
                
        eventNameArray.each do |event|
            nameArray << event['name']
            nameHash.store("#{event['name']}", "#{event['_embedded']['venues'].first.values_at("name")}")                 
        end

        userSelection = prompt.select("Pick an event", nameArray, cycle: true)
        theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
        newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
        $user.save
        prompt.warn("Ticket purchased!")
    end
end 

def find_events_by_type(classificationName, city)
    prompt = TTY::Prompt.new
    events_results_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?classificationName=#{classificationName}&city=#{city}&apikey=@apiKey")
    events_results_hash = JSON.parse(events_results_string)
    
    if events_results_hash["_embedded"] == nil
        prompt.error("No events found")
        main_menu
    else
        # events_array = events_results_hash["_embedded"]["events"]
        # events_array.each do |event|
        #     puts event["name"]

        eventNameArray = events_results_hash["_embedded"]["events"].map
        nameHash = {}
        nameArray = []
                
        eventNameArray.each do |event|
            nameArray << event['name']
            nameHash.store("#{event['name']}", "#{event['_embedded']['venues'].first.values_at("name")}")                 
        end

        userSelection = prompt.select("Pick an event", nameArray, cycle: true)
        theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
        newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
        $user.save
        prompt.warn("Ticket purchased!")
    end
end 

def find_events_by_venue(venue)
    prompt = TTY::Prompt.new
    events_results_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=@apiKey&keyword=#{venue}")
    events_results_hash = JSON.parse(events_results_string)
    
    if events_results_hash["_embedded"] == nil
        prompt.error("No events found")
        main_menu
    else
        # events_array = events_results_hash["_embedded"]["events"]
        # events_array.each do |event|
        #     puts event["name"]

        eventNameArray = events_results_hash["_embedded"]["events"].map
        nameHash = {}
        nameArray = []
                
        eventNameArray.each do |event|
            nameArray << event['name']
            nameHash.store("#{event['name']}", "#{event['_embedded']['venues'].first.values_at("name")}")                 
        end

        userSelection = prompt.select("Pick an event", nameArray, cycle: true)
        theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
        newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
        $user.save
        prompt.warn("Ticket purchased!")
    end
end

def find_events_by_date(start_date, end_date, city)
    prompt = TTY::Prompt.new
    events_results_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=@apiKey&localStartEndDateTime=#{start_date},#{end_date}&city=#{city}")
    events_results_hash = JSON.parse(events_results_string)
    
    if events_results_hash["_embedded"] == nil
        prompt.error("No events found")
        main_menu
    else
        # events_array = events_results_hash["_embedded"]["events"]
        # events_array.each do |event|
        #     puts event["name"]

        eventNameArray = events_results_hash["_embedded"]["events"].map
        nameHash = {}
        nameArray = []
                
        eventNameArray.each do |event|
            nameArray << event['name']
            nameHash.store("#{event['name']}", "#{event['_embedded']['venues'].first.values_at("name")}")                 
        end
        
        userSelection = prompt.select("Pick an event", nameArray, cycle: true)
        theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
        newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
        $user.save
        prompt.warn("Ticket purchased!")
    end
end