require 'httparty'

class Abilities
	include HTTParty
	base_uri ENV['OVERWATCH_API']

	def fetch_all(query = {})
		self.class.get '/api/v1/ability', query: query
	end

	def fetch(ability_id)
		self.class.get "/api/v1/ability/#{ability_id}"
	end
end
