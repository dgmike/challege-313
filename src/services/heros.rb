require 'httparty'

class Hero
	include HTTParty
	base_uri ENV['OVERWATCH_API']

	def fetch_all(query = {})
		self.class.get '/api/v1/hero', query: query
	end
end