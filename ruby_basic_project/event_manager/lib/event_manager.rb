puts 'Event Manager Initialized!'

# contents = File.read('event_attendees.csv')
# puts contents

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
# lines = File.readlines('event_attendees.csv')
# lines.each_with_index do |line, index|
#   next if index == 0 # continue

#   columns = line.split(",")
#   name = columns[2]
#   puts name
# end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
  #   if zipcode.nil?
  #     '00000'
  #   elsif zipcode.length < 5
  #     zipcode.rjust(5, '0')
  #   elsif zipcode.length > 5
  #     zipcode[0..4]
  #   else
  #     zipcode
  #   end
end

def clean_phone_number(phone_number)
  phone_number.gsub!(/[^\d]/, '')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == "1"
    phone_number[1..10]
  else
    "Wrong Number!!"
  end
end

def format_date(date)
  DateTime.strptime(date, "%m/%d/%y %H:%M")
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  # handle error by begin => rescue (try catch)

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(", ")
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def count_frequency(array)
  array.max_by { |a| array.count(a) }
  # arr = Hash.new(0)
  # array.each { |a| arr[a]+=1}
  # array.uniq.map{ |n| array.count(n)}.max
end

# using CSV lib => convert header

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

# create templete like pub file in nodejs
template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

Dir.mkdir('output') unless Dir.exist?('output')

hour_of_day = Array.new([])
day_of_week = Array.new([])

cal = { 0 => "sunday", 1 => "monday", 2 => "tuesday", 3 => "wednesday", 4 => "thursday", 5 => "friday", 6 => "saturday" }

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  register_date = format_date(row[:regdate])
  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)
  phone_number = clean_phone_number(row[:homephone])

  form_letter = erb_template.result(binding)
  # convert date
  hour_of_day.push(register_date.hour)
  day_of_week.push(register_date.wday)
  # write to file
  thank_you_letter(id, form_letter)
end

puts "Most Active Hour is : #{count_frequency(hour_of_day)}"
puts "Most Active Day is : #{cal[count_frequency(day_of_week)].capitalize}"
