
def first_page
  require 'open-uri'
  require 'net/http'
  require 'nokogiri'
  require 'httparty'
  require 'csv'


  url = "https://winerelease.com/Winery_List/Alphabetical_Winery_List.html"

  resp = HTTParty.get(url)
  html = resp.body
  doc = Nokogiri::HTML(html)
  ul = doc.css('ul')
  winery_list_items = ul.css('li')

  # GETS URL
  winery_links = winery_list_items.css('a')
  puts winery_links

  # GETS Location List
  location_arr = []
  locations = winery_list_items.each { | location | location_arr << location.text}


  # First Page Links
  first_page_list = []
  names_arr = []
  winery_links.each do |winery|
    link = winery.attribute('href')
    name = winery.text
    first_page_list << link
    names_arr << name
  end
  # Second Page List
  # second_page_list = []


  headers = ["Name", "Info_link", "Location", "Website"]
  CSV.open('wineries.csv', 'w') do |csv|
    csv << headers
    location_index = 0
    first_page_index = 0
    name_index = 0
    # second_page_index = 0

    winery_links.each do |winery|
      name = names_arr[name_index]
      first_page_link = first_page_list[first_page_index]
      location = location_arr[location_index]
      winery_data = [name, first_page_link, location]
      csv << winery_data
      location_index += 1
      first_page_index += 1
      name_index += 1
    end
  end
end

def web_site(url)
  require 'watir'
  require 'webdrivers'
  browser = Watir::Browser.new
  puts url
  puts url.class
  # browser.goto("#{url}")
  # second_parsed_page = Nokogiri::HTML(browser.html)
  # File.open('parsed.txt', 'w') { |f| f.write second_parsed_page.to_s }
  # div = second_parsed_page.css('font')
  # links = div.css('a')
  # links.first.attribute('href')
  browser.close
end

first_page
