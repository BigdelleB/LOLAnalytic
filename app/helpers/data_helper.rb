module DataHelper

	require 'net/http'
	require 'open-uri'

	@@champion_name
	@@champ_id


	#gets the JSON values I need from a champion to start calling more advanced methods
	def extractJSON(login)
		username= login.fetch(:Username)
		@@champion_name=username
		region= login.fetch(:Region)
		url="https://"+region+".api.pvp.net/api/lol/"+region+"/v1.4/summoner/by-name/" + username+"?api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
		uri=URI.parse(url)
		uri=uri.open
		str=uri.read
		return str
	end

	#gets the summoner_id
	def summoner_id(login)
		champion= extractJSON(login)
		id = JSON.parse(champion)['chelski']['id']
		@@champ_id=id
		return id
		
	end 


	def summoner_avg_kills_per_game(login)
		
	end
end
