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
        abrevs = ["3M", "AFAR", "AH", "AHB", "AR", "AWC", "BGG", "BGSB", "BUC", "CB", "CHB", "CLMP", "CO", "EC", "FEB", "FPC", "HSB", "HUC", "IGAB", "IVEY", "KB", "KUC", "LB", "LRI", "LWH", "MB", "MC", "MOG", "MSB", "NCB", "PAB", "SH", "SSC", "TC", "TEB", "TH", "TL", "TRAC", "UC", "UCC", "VAC", "WCS", "WL", "WSC"]
        
        long = ["3M Centre", "Advanced Facioptionty For Avain Research", "Alumni Hall", "Arts and Humanities Building", "Government of Canada Agriculture Institute", "Alumni Western Centre","3M Biological and Geological Greenhouse" ,"Biological and Geological Sciences Building","Brescia University College", "Coloption Building", "Chemistry Building", "Claudette Mackay-Lassonde Pavillon", "Cronyn Observatory", "Elborne College", "John George Althouse Faculty of Education Building", "Fraunhofer Project Centre for Composites Research", "Arthur and Sonia Labatt Health Sciences Building", "Huron University College","International Graduate Affairs Building", "Richard Ivey Building", "Kresege Building", " King's University College", "Josephine Spencer Niblett Law Building", "Lawson Research Institute", "Lawson Hall", "Music Building", "Middlesex College", "The Gordon J. Mogenson Building", "Medical Sciences building", "North Campus Building", "Physics and Astronomy Building", "Somerville House", "Social Science Centre", "Talbot College", "Thomposon Engineering Building", "Thames Hall", "Allyn and Betty Taylor Library", "Thompson Recreation and Athletic Centre", "Western Continuing Studies", "Weldon Library", "Laurene O. Paterson Western Science Centre"]
        
        @title = long[abrevs.index(params["building"])]
        
        @time = Time.new
        @rooms = Room.where(building: params["building"])
        @military_curr = (@time.hour.to_s + ":" + @time.min.to_s)
        #cd = time.wday
        @cd = 2
        if(@cd == 0 or @cd == 6) # If it's the weekend. 
            @curr_day = "we"
        else
            @curr_day = day_to_char(@cd)
        end
    end
    
    helper_method :compare
end
