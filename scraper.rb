
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
def first_page
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
  table = doc.css('td')
  winery_links = table.css('a')



  headers = ["Name", "Link"]
  CSV.open('wineries.csv', 'w') do |csv|
    csv << headers
    winery_links.each do |winery|
      url = winery.attribute("href")
      winery_data = [winery.text, url]
      csv << winery_data
    end
  end
end


def web_site
  require 'watir'
  require 'webdrivers'
  browser = Watir::Browser.new
  browser.goto ("https://www.winerelease.com/WineryInfo/Filomena_wine_releases.html")
  second_parsed_page = Nokogiri::HTML(browser.html)
  File.open('parsed.txt', 'w') { |f| f.write "#{second_parsed_page}" }
  div = second_parsed_page.css("font")
  links = div.css("a")

  website = links.first.attribute("href")
  puts website
end

web_site
