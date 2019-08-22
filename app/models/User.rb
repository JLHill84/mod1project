class User < ActiveRecord::Base

    has_many :tickets
    has_many :venues, through: :tickets


    # def venues
    #     tickets = []
    #     Ticket.all.each do | ticket | tickets << ticket.venue
    #       if ticket.user == self
    #       end
    #     end
    #     return tickets
    #   end
    
    #   def tickets
    #     Ticket.all.select { | ticket | ticket.user == self}
    #   end


end