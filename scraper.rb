# require 'watir'
# require 'webdrivers'
# require 'nokogiri'

# browser = Watir::Browser.new
# browser.goto 'https://www.brewersassociation.org/directories/breweries/'
# parsed_page = Nokogiri::HTML(browser.html)

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
