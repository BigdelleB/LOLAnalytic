class Login < ActiveRecord::Base
	require 'open-uri'

	validates :Username, :presence => true
	validates :Region, :presence => true
	#validate :valid_name
  
  
 



  
 def valid_name
   	username=:Username
   	region=:Region
 	result=region.to_s+".api.pvp.net/api/lol/"+region.to_s+"/v1.4/summoner/by-name/"+username.to_s+"?api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326"
 	
 	Net::HTTP.start(result) do |http|
 		response =http.status[0]
 		if response!=200
 		error.add(:login, "Summoner name not valid")
 	end
end










end
  


end

