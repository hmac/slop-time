require "net/http"

events_url = "https://cosmicslop.org/tickets/"
href_pattern = /class="group" href="([^"]+)/

puts "Downloading #{events_url}"
page = Net::HTTP.get(URI(events_url))

puts "Finding event links"
links = page.scan(href_pattern)

puts "Found #{links.length} links."

puts "Fetching existing links."
existing_links = File.readlines("links.txt")
puts "Found #{existing_links.length} existing links."

# Filter out the ones that already exist
new_links = links - existing_links

if new_links.empty?
  puts "There are no new links, exiting."
  exit(0)
end

puts "There are #{new_links.length} new links:"
links.each { |link| puts link }

puts "Writing new links to links.txt"
File.open("links.txt", "a") do |file|
  new_links.each { |l| file.puts(l) }
end

puts "Creating issues for new links"
new_links.each do |link|
  issue_body = "#{link}\n\n@hmac"
  `gh issue create --title "#{link}" --body "#{issue_body}"`
end
