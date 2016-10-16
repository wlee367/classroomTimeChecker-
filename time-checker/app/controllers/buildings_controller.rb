class BuildingsController < ApplicationController
    
    def index
        alphabet = ["a%","b%","c%","d%","e%","f%","g%","h%","i%","j%","k%","l%","m%","n%","o%","p%","q%","r%","s%","t%","u%","v%","w%","x%","y%","z%"]
        
        @buildings = []
        
        alphabet.each_with_index do |letter, i|
            @buildings.push(Room.where('building LIKE ?', letter).order(:building))
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
        abrevs = ["3M", "AH", "AHB", "AWC", "BGSB", "BUC", "CB", "CHB", "CLMP", "EC", "FEB", "HSB", "HUC", "IVEY", "KB", "KUC", "LB", "LWH", "MB", "MC", "MOG", "MSB", "NCB", "PAB", "SH", "SSC", "TC", "TEB", "TH", "UC", "UCC", "WCS", "WL", "WSC"]
        
        long = ["3M Centre", "Alumni Hall", "Arts and Humanities Building", "Alumni Western Centre","Biological and Geological Sciences Building","Brescia University College", "Coloption Building", "Chemistry Building", "Claudette Mackay-Lassonde Pavillon", "Elborne College", "John George Althouse Faculty of Education Building", "Arthur and Sonia Labatt Health Sciences Building", "Huron University College", "Richard Ivey Building", "Kresege Building", " King's University College", "Josephine Spencer Niblett Law Building",  "Lawson Hall", "Music Building", "Middlesex College", "The Gordon J. Mogenson Building", "Medical Sciences building", "North Campus Building", "Physics and Astronomy Building", "Somerville House", "Social Science Centre", "Talbot College", "Thomposon Engineering Building", "Thames Hall","University College", "University Community Centre" "Western Continuing Studies", "Weldon Library", "Laurene O. Paterson Western Science Centre"]
        
        @title = long[abrevs.index(params["building"])]
        
        @bname = params["building"]
        
        @time = Time.new
        @rooms = Room.where(building: params["building"])
        @military_curr = (@time.hour.to_s + ":" + @time.min.to_s)
        #@cd = @time.wday
        @cd = 2
        if(@cd == 0 or @cd == 6) # If it's the weekend. 
            @curr_day = "we"
        else
            @curr_day = day_to_char(@cd)
        end
    end
    
    helper_method :compare
end
