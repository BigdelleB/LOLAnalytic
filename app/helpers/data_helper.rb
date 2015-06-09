module DataHelper

	require 'net/http'
	require 'open-uri'

	@@champion_name
	@@champ_id
	@@region


	#gets the JSON values I need from a champion to start calling more advanced methods
	def extractJSON(login)
		username= login.fetch(:Username)
		@@champion_name=username
		region= login.fetch(:Region)
		@@region=region
		url="https://"+region+".api.pvp.net/api/lol/"+region+"/v1.4/summoner/by-name/" + username+"?api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
		uri=URI.parse(url)
		#uri=uri.open
		str=uri.read
		return str
	end

	#initializes the champion id 
	def summoner_id(login)
		champion= extractJSON(login)
		id = JSON.parse(champion)['chelski']['id']
		@@champ_id=id
		
	end 

	#returns massive JSON of ranked stats BY CHAMPIONID
	def ranked_stats_JSON(login)
		summoner_id(login)
		url="https://"+@@region+".api.pvp.net/api/lol/"+@@region+"/v1.3/stats/by-summoner/"+@@champ_id.to_s+"/ranked?season=SEASON2015&api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
		uri=URI.parse(url)
		str=uri.read
		return str
	end

	#get every champion used by id and then store in array, iterate through each champions id and get a smaller array of the stats im interested
	#in like kills deaths etc, return each array of data 
	
end
