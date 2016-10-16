class RoomController < ApplicationController
    def index
        alphabet = ["a%","b%","c%","d%","e%","f%","g%","h%","i%","j%","k%","l%","m%","n%","o%","p%","q%","r%","s%","t%","u%","v%","w%","x%","y%","z%"]
        
        @rooms = []
        
        alphabet.each_with_index do |letter, i|
            @rooms.push(Room.where('identifier LIKE ?', letter).order(:identifier))
        end
    end
    
    def day_to_char(day)
        if day == 1
            return "M"
        elsif day == 2
            return "T"
        elsif day == 3
            return "W"
        elsif day == 4
            return "H"
        elsif day == 5
            return "F"
        else
            puts "ERROR: Invalid day."
        end
    end
    
    def int_to_day(day)
        if day == 1
            return "Monday"
        elsif day == 2
            return "Tuesday"
        elsif day == 3
            return "Wednesday"
        elsif day == 4
            return "Thursday"
        elsif day == 5
            return "Friday"
        else
            puts "ERROR: Invalid day."
        end
    end
    
    # Horrible method but straped for time.
    def compare(curr, curr_d, startT, endT, days)
        
        if(curr_d == 0 or curr_d == 6) # If it's the weekend. 
            return false 
        end

        curr_char = day_to_char(curr_d)
        
        if(not days.include?(curr_char))
            return false
        end
        
        currH = curr.split(":")[0].to_i
        currM = curr.split(":")[1].to_i
        
        startH = startT.split(":")[0].to_i
        startM = startT.split(":")[1].to_i
        
        endH = endT.split(":")[0].to_i
        endM = endT.split(":")[1].to_i
        
        if currH < startH or currH > endH
            return false 
        end
        
        if currH > startH and currH < endH
            return true
        end
        
        if currH == startH
            return currM > startM 
        end
        
        if currH == endH
            return currM < endM
        end       
    end
    
    def show
        
        @courses = Course.where(location: params[:location]).order(:start)
        
        @is_free = true
        @room_loc = params[:location]
        
        time = Time.new
        military_curr = (time.hour.to_s + ":" + time.min.to_s)
        current_day = time.wday
        
        #military_curr = "13:30"
        current_day = 2
        
        @text_day = int_to_day(current_day)
        
        @courses.each do |c|
            if compare(military_curr, current_day, c.start, c.end, c.days)
                @is_free = false 
                @unsat = c
                break
            end
        end
    end
end
