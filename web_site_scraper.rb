require 'watir'
require 'webdrivers'
require 'csv'
require 'json'

links_list = []
website_list = []
headers = ["Websites"]

## PARSING
puts "PARSING LINKS FROM CSV"
csv = CSV.foreach('./wineries.csv') do | row |
  links_list << row[1]
end
puts "PARSING COMPLETE"


##  FETCHING WEBSITE
links_list.each do | website |
  browser = Watir::Browser.new
  puts "Fetching from Winery Page: #{website}"
  browser.goto(website)
  second_parsed_page = Nokogiri::HTML(browser.html)
  File.open('parsed.txt', 'w') { |f| f.write second_parsed_page.to_s }

  ## ERROR CHECK
  if browser.text.include?("404")
    website_list << "Error 404"
  else
    div = second_parsed_page.css('font')
    links = div.css('a')
    puts "Fetch completed. Found: #{links.first.attribute('href')}"
    website_list << links.first.attribute('href')
  end
  browser.close

  ## Pushing to CSV
  puts "Reading to CSV"
  CSV.open('wineries_websites.csv', 'w') do |csv|
  csv << headers
  website_index= 0

  website_list.each do | website |
    website = website_list[website_index]
    website_data = [website]
    csv << website_data
    website_index += 1
  end
end
puts "Completed. Continuing with next one\n"
end
