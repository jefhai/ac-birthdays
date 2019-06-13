require 'json'
require "open-uri"

inputJsonFilePath = ARGV[0]

puts "Input json: #{inputJsonFilePath}"
puts "Extracting..."

jsonContent = File.read(inputJsonFilePath)
json = JSON.parse(jsonContent)

json.each do |item|

	begin
		image = item["image"]
		charName = item["name"]

		url = "http://www.animal-crossing.com/assets/img/characters/" + image

		open(url) {|f|
   			File.open("Images/" + charName + ".png", "wb") do |file|
				file.puts f.read
			end
		}
	end

	rescue => e
		case e
			when OpenURI::HTTPError
				puts "404: " + url
			else
				puts "Failed: " + url
		end
		
end
