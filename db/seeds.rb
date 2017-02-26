require 'nokogiri'
require 'open-uri'

#fetching entire site html page
data = Nokogiri::HTML(open("http://www.latlong.net/category/cities-102-15.html"))

#fetching cities list from site
rows = data.css('table').xpath('./tr')
rows.collect do |row|
	#getting place name and splitting with ,
	# after splitting we are getting city, state, country
	names = row.at_xpath('td[1]/a/text()').to_s.strip.split(",")
	if names.length == 3
		#checking already city, state, country exsists or not, if not exsists creating the country, state, city
		country = Country.find_or_create_by(name:names[2].strip)
		state = State.find_or_create_by(name:names[1], country_id:country.id)
		city = City.find_or_create_by(name:names[0],state_id:state.id)
		city.update_attributes({latitude: row.at_xpath('td[2]/text()').to_s.strip, 
								longitude: row.at_xpath('td[3]/text()').to_s.strip})
	end
end