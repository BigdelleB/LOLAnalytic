class Login < ActiveRecord::Base
	require 'open-uri'
	validates :Username, :presence => true
	validates :Region, :presence => true
	validate :valid_level
  
  
  def valid_level
    username=:Username
    region=:Region
    open("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/a?api_key=28ba1d65-cda8-4e79-90ad-aad6b1ab6326")
	rescue OpenURI::HTTPError
	      errors.add(:login, "Something went wrong, summoner info was entered incorrectly")
	else
		return 
	end
  	
  end
  




