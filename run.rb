require "net/http"

events_url = "https://cosmicslop.org/tickets/"
href_pattern = /class="group" href="([^"]+)/

puts "Downloading #{events_url}"
page = Net::HTTP.get(URI(events_url))

puts "Finding event links"
links = page.scan(href_pattern)

puts "Found #{links.length} links:"
links.each do |link|
  puts link
end

# TODO:
# 1. read existing links from a file
# 2. filter out the ones that already exist
# 3. write the new ones to the file
# 4. create an issue for each new link
# 5. tag me?
