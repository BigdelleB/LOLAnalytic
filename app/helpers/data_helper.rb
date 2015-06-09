module DataHelper

	require 'net/http'
	require 'open-uri'

	@@champion_name
	@@champ_id
	@@region
	@@overall_ranked_stats


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
		id = JSON.parse(champion)[@@champion_name]['id']
		@@champ_id=id
	end 

	#returns massive JSON of ranked stats BY CHAMPIONID
	def ranked_stats_JSON(login)
		summoner_id(login)
		url="https://"+@@region+".api.pvp.net/api/lol/"+@@region+"/v1.3/stats/by-summoner/"+@@champ_id.to_s+"/ranked?season=SEASON2015&api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
		uri=URI.parse(url)
		str=uri.read
		@@overall_ranked_stats=str;
		
	end

	#method to return an array of the champion id's used in ranked
	def get_champ_ids

		jason=JSON.parse(@@overall_ranked_stats)['champions']
		champs=jason.size
		id_array=[0..champs]

		for i in 0..(champs-1)
			id_array.insert(i,JSON.parse(@@overall_ranked_stats)['champions'][i])
		end

		id_array2=[]

		for i in 0..(champs-1)
			id_array2.insert(i,id_array[i]['id'])
		end
		
		return id_array2
	end

	#returns the ranked champions names used
	def get_champ_names
		id_array=get_champ_ids
		champ_names=[]
		#the last id is always 0, this 0 gives the overall kills and overall stats, not per champion, so we dont want 0..4, we'd want 0..3
		for i in 0..(id_array.size-2)
			url ="https://global.api.pvp.net/api/lol/static-data/"+@@region+"/v1.2/champion/"+id_array[i].to_s+"?api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
			uri=URI.parse(url)
			str=uri.read
			champ_names.insert(i,JSON.parse(str)['name'])
		end
		return champ_names
	end

	


end
