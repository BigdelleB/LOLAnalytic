module DataHelper

	require 'net/http'
	require 'open-uri'

	#the username of the summoner
	@@champion_name
	#the id of the summoner, needed to make more advanced API calls
	@@champ_id
	#the region of the champion
	@@region
	#massive JSON of every kills,deaths etc for each champion used in a ranked game
	@@overall_ranked_stats
	#if the summoner is not lvl 30 this will not work, we have to check
	@@lvl
	#field that holds the number of champions that this summoner uses in ranked games
	@@number_of_champs




	#gets the JSON values I need from a champion to start calling more advanced API calls
	def extractJSON(login)
		username= login.fetch(:Username)
		@@champion_name=username
		region= login.fetch(:Region)
		@@region=region
		url="https://"+region+".api.pvp.net/api/lol/"+region+"/v1.4/summoner/by-name/" + username+"?api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
		uri=URI.parse(url)
		#uri=uri.open
		str=uri.read
		@@lvl=JSON.parse(str)[@@champion_name]["summonerLevel"]
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
		if @@lvl<30
			return "Summoner not ranked"
		
		else 
			summoner_id(login)
			url="https://"+@@region+".api.pvp.net/api/lol/"+@@region+"/v1.3/stats/by-summoner/"+@@champ_id.to_s+"/ranked?season=SEASON2015&api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
			uri=URI.parse(url)
			str=uri.read
			@@overall_ranked_stats=str;
		end

		
	end

	#method to return an array of the champion id's used in ranked
	def get_champ_ids
		if @@lvl<30
			return "Summoner not ranked"
		
		else 
			jason=JSON.parse(@@overall_ranked_stats)['champions']
			champs=jason.size
			@@number_of_champs=champs-1;
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
	end

	#returns the ranked champions names used
	def get_champ_names
		if @@lvl<30
			return "Summoner not ranked"
		
		else
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

	#method to give array of avg kills per game, avg deaths per game, avg assists per game, avg damage dealt with champ per game, avg gold per game
	def avg_kills_per_game
		#initialize double array
		stats=[]

		all_info=@@overall_ranked_stats
		puts @@number_of_champs
		i=0
		while i<@@number_of_champs.to_i
			overallkills= JSON.parse(all_info)['champions'][i]['stats']['totalChampionKills']
			total_games=JSON.parse(all_info)['champions'][i]['stats']['totalSessionsPlayed']
			avg=overallkills/total_games.to_f
			
			stats.insert(i,avg)
			i=i+1
		end	
		return stats
	end 

	#avg deaths per game
	def avg_deaths_per_game
		#initialize double array
			stats=[]

			all_info=@@overall_ranked_stats
			puts @@number_of_champs
			i=0
			while i<@@number_of_champs.to_i
				overalldeaths= JSON.parse(all_info)['champions'][i]['stats']['totalDeathsPerSession']
				total_games=JSON.parse(all_info)['champions'][i]['stats']['totalSessionsPlayed']
				avg=overalldeaths/total_games.to_f
				
				stats.insert(i,avg)
				i=i+1
			end	
			return stats
	end 

	#avg assists per game
	def avg_assists_per_game
		#initialize double array
			stats=[]

			all_info=@@overall_ranked_stats
			puts @@number_of_champs
			i=0
			while i<@@number_of_champs.to_i
				overallassists= JSON.parse(all_info)['champions'][i]['stats']['totalAssists']
				total_games=JSON.parse(all_info)['champions'][i]['stats']['totalSessionsPlayed']
				avg=overallassists/total_games.to_f
				
				stats.insert(i,avg)
				i=i+1
			end	
			return stats
	end 

	#avg overall damage dealt per game
	def avg_damage_per_game
		#initialize double array
			stats=[]

			all_info=@@overall_ranked_stats
			puts @@number_of_champs
			i=0
			while i<@@number_of_champs.to_i
				overalldamage= JSON.parse(all_info)['champions'][i]['stats']['totalDamageDealt']
				total_games=JSON.parse(all_info)['champions'][i]['stats']['totalSessionsPlayed']
				avg=overalldamage/total_games.to_f
				
				stats.insert(i,avg)
				i=i+1
			end	
			return stats
	end 

	def avg_gold_per_game
		#initialize double array
			stats=[]

			all_info=@@overall_ranked_stats
			puts @@number_of_champs
			i=0
			while i<@@number_of_champs.to_i
				overallgold= JSON.parse(all_info)['champions'][i]['stats']['totalGoldEarned']
				total_games=JSON.parse(all_info)['champions'][i]['stats']['totalSessionsPlayed']
				avg=overallgold/total_games.to_f
				
				stats.insert(i,avg)
				i=i+1
			end	
			return stats
	end 





end
