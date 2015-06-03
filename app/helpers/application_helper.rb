module ApplicationHelper
	require 'net/http'
	require 'open-uri'

	def extractJSON(login)
		username= login.Username
		region= login.Region
		url="https://"+region+".api.pvp.net/api/lol/"+region+"/v1.4/summoner/by-name/" + username+"?api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
		#url=URI.parse(URI.encode(url.strip))
		uri=URI.parse(url)
		uri=uri.open
		str=uri.read
		return str



		#result= Net::HTTP.get(URI.parse(url))
		#result= RestClient.get(result)
		
		#puts result;
	end
end
