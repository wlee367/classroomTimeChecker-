require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', '../scrape_data/Data.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1', :col_sep => " ")

csv.each do |row|
    c = Course.new
    c.typeS = row['Course']
    c.code = row['Code']
    c.start = row['Start']
    c.end = row['End']
    c.location = row['Location']
    c.days = row['Days']
    c.save(validate: false)
    
    
    r = Room.find_or_create_by(identifier: row['Location'], building: row['Location'].split("-")[0], r_num: row['Location'].split("-")[1])
end
    
puts "Initialized #{Room.count} rooms."
puts "Initialized #{Course.count} courses."
