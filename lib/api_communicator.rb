def find_events_by_zip_code(zip_code)
    events_results_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=FU4GMZjNo1N2AxOwXrVwwmZDw8MjQD8f&postalCode=#{zip_code}")
    events_results_hash = JSON.parse(events_results_string)
    
    if events_results_hash["_embedded"] == nil
        puts "No events found"
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
        prompt = TTY::Prompt.new
        userSelection = prompt.select("Pick an event", nameArray, cycle: true)
        theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
        newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
        $user.save
        prompt.warn("Ticket purchased!")
    end
end 

def find_events_by_type(classificationName, city)
    events_results_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?classificationName=#{classificationName}&city=#{city}&apikey=FU4GMZjNo1N2AxOwXrVwwmZDw8MjQD8f")
    events_results_hash = JSON.parse(events_results_string)
    
    if events_results_hash["_embedded"] == nil
        puts "No events found"
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
        prompt = TTY::Prompt.new
        userSelection = prompt.select("Pick an event", nameArray, cycle: true)
        theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
        newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
        $user.save
        prompt.warn("Ticket purchased!")
    end
end 

def find_events_by_venue(venue)
    events_results_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=FU4GMZjNo1N2AxOwXrVwwmZDw8MjQD8f&keyword=#{venue}")
    events_results_hash = JSON.parse(events_results_string)
    
    if events_results_hash["_embedded"] == nil
        puts "No events found"
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
        prompt = TTY::Prompt.new
        userSelection = prompt.select("Pick an event", nameArray, cycle: true)
        theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
        newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
        $user.save
        prompt.warn("Ticket purchased!")
    end
end

def find_events_by_date(start_date, end_date, city)
    events_results_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=FU4GMZjNo1N2AxOwXrVwwmZDw8MjQD8f&localStartEndDateTime=#{start_date},#{end_date}&city=#{city}")
    events_results_hash = JSON.parse(events_results_string)
    
    if events_results_hash["_embedded"] == nil
        puts "No events found"
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
        prompt = TTY::Prompt.new
        userSelection = prompt.select("Pick an event", nameArray, cycle: true)
        theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
        newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
        $user.save
        prompt.warn("Ticket purchased!")
    end
end






# def get_events_from_api(city, genre)
    
#     response_string = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=37zNi3JGSm5xKVWdPVAKsUJB7cfQVoyg&city=#{city}&classificationName=#{genre}")
#     response_hash = JSON.parse(response_string)

#     if response_hash.length < 3
#         puts "No events found, please try a different city."
#         getCity
#     else
#         eventNameArray = response_hash["_embedded"]["events"].map
#         nameHash = {}
#         nameArray = []
        
#         eventNameArray.each do |event|

#             nameArray << event['name']
#             nameHash.store("#{event['name']}", "#{event['_embedded']['venues'].first.values_at("name")}")
           
#         end

#         prompt = TTY::Prompt.new
#         userSelection = prompt.select("Pick an event", nameArray, cycle: true)
#         theVenue = Venue.create(ticketName: userSelection, venueName: "#{nameHash.values_at(userSelection).pop.to_str.tr('[]"', "")}", userName: $user.userName)
#         newTicket = Ticket.create(ticketName: userSelection, venueName: theVenue.venueName, userName: $user.userName)
#         $user.ticketName = userSelection
#         $user.save
        
#     end

# end