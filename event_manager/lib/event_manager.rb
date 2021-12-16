require 'csv'
require 'erb'
require 'google/apis/civicinfo_v2'

DAYS = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(phone_number)
  number = phone_number.tr('- \(\).', '')
  number = number.chars[1..number.chars.length].join if number.chars.length == 11 && (number[0] == '1')
  number.to_i.to_s.rjust(10, '0')[0..9]
end

def get_peak_registration_hour(hours)
  peak_registration_hour = hours.max_by { |hour| hours.count(hour) }
  "#{peak_registration_hour}:00"
end

def get_peak_registration_day(days)
  peak_registration_day = days.max_by { |day| days.count(day) }
  DAYS[peak_registration_day]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def get_content(file_name)
  CSV.open(file_name, headers: true, header_converters: :symbol) if File.exist? file_name
end

puts 'Event Manager Initialized!'

content = get_content('event_attendees.csv')
template_letter = File.read 'form_letter.erb' if File.exist? 'form_letter.erb'
erb_template = ERB.new template_letter
registration_hours = []
registration_days = []


content.each do |row|
  id = row[0]
  name = row[:first_name]
  registration_hours << DateTime.strptime(row[:regdate].to_s, '%m/%d/%y %H:%M').hour
  registration_days << DateTime.strptime(row[:regdate].to_s, '%m/%d/%y %H:%M').wday
  peak_registration_hour = get_peak_registration_hour(registration_hours)
  peak_registration_day = get_peak_registration_day(registration_days)
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)
  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end
