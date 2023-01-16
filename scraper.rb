# require 'watir'
# require 'webdrivers'
# require 'nokogiri'

# browser = Watir::Browser.new
# browser.goto 'https://www.g2.com/products/crisp/reviews#reviews'
# parsed_page = Nokogiri::HTML(browser.html)

# puts parsed_page
# File.open("parsed.txt", "w") { |f| f.write "#{parsed_page}" }

# puts "before xpath"
# breweries = parsed_page.xpath("//div[contains(@class, 'company-content')]")
# puts "after xpath"
# puts breweries

# breweries.each do |brewery|
#   puts "pewpew"
#   name = brewery.xpath("h3[@class='with-mini-hr']/a/@name")
#   puts name
# end

# browser.close

require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'httparty'
require 'csv'

url = "https://winerelease.com/"

# headers = ""
resp = HTTParty.get(url)
html = resp.body

doc = Nokogiri::HTML(html)
table = doc.css("td")
winery_links = table.css("a")

winery_arr = []

winery_links.each do |winery|
  # puts winery.text
  # puts winery.attribute("href")
  winery_arr.push([winery.text, winery.attribute("href")])
end

puts winery_arr

headers = ["Name", "Link"]
CSV.open('wineries.csv', "w") do |csv|
  csv << headers
  winery_links.each do |winery|
    winery_data = [winery.text, winery.attribute("href")]
    csv << winery_data
  end
end
