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
    div = second_parsed_page.css('font').first
    puts "This is the DIV\n #{div}"
    links = div.css('a')
    final_link = ""


  ## Bugs #1 - DIV is not the correct <font> on the page.
  ## Bugs #2 - It catches too many hrefs.
  ## Bug occurs because it finds several things that is not twitter, facebook or google, and thus changes the value of the final link over and over.

    puts "Getting links....."
    links.each do |link|
      href = link.attribute('href').to_s
      puts href.class

      # if href.include?("google") || href.include?("twitter") || href.include?("facebook") || href.include?("")
      #   puts "Link contained bad word. Skipping onto next link."
      # else
      #   website_list << href
      #   # final_link = href
      # end
    end
  end
  browser.close

  # Pushing to CSV
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
