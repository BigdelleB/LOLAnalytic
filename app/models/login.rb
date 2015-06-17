class Login < ActiveRecord::Base
	require 'open-uri'

	validates :Username, :presence => true
	validates :Region, :presence => true
	validate :valid_name


 def valid_name
   	username=read_attribute(:Username)
    region=read_attribute(:Region)
 	result="https://"+region.to_s+".api.pvp.net/api/lol/"+region.to_s+"/v1.4/summoner/by-name/"+username.to_s+"?api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"

 	begin
 		value=open(result)

		#status=value.stats[0]
		#if status.to_i!=200
		#	errors.add(:login,status)
		#end
	
 	#rescue OpenURI::HTTPError
 	#	errors.add(:login, "champion name may have been entered incorrectly")
 	#rescue SocketError
 	#	errors.add(:Please, "make sure that the Username AND Region were entered correctly")
 	#end
	end
	uri=URI.parse(result)
	
	str=uri.read
	lvl=JSON.parse(str)[username]["summonerLevel"]

	if lvl.to_i!=30
		errors.add(:Champion, "is not level 30")
	end
 	rescue SocketError
 		errors.add(:login, "champion name may have been entered incorrectly")
 	rescue URI::InvalidURIError
		errors.add(:Issue, "make sure you entered everything correctly")
	rescue OpenURI::HTTPError
 		errors.add(:login, "champion name may have been entered incorrectly")
 	end

  

end





