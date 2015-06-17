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
		status=value.status[0]
		if status.to_i!=200
			errors.add(:login,status)
		end
 	rescue OpenURI::HTTPError
 		errors.add(:login, "champion is not correct level or name may have been entered incorrectly")
 	rescue SocketError
 		errors.add(:login, "Please make sure that the Username AND Region were entered correctly")
 	end

 	uri=URI.parse(result)
		#uri=uri.open
		str=uri.read
		lvl=JSON.parse(str)[username]["summonerLevel"]

		if lvl!=30
			errors.add(:login, "You are not level 30 yet, this is only for ranked statistics")
		end


  	end

end





