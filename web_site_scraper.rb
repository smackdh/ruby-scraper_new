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
