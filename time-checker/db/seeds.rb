require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', '../scrape_data/data.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1', :col_sep => " ")

csv.each do |row|
    c = Course.new
    c.code = row['Code']
    c.start = row['Start']
    c.end = row['End']
    c.location = row['Location']
    c.days = row['Days']
    c.save(validate: false)
end

puts "Initialized #{Course.count} courses."