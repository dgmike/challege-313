require 'sinatra'
require 'json'
require './services/heros'

hero_service = Hero.new

get '/' do
	status 200
	headers 'Content-Type' => 'application/json; charset=utf-8'

	body JSON.dump links: {
		self: '/',
		api: '/api'
	}
end

get '/api' do
	status 200
	headers 'Content-Type' => 'application/json; charset=utf-8'

  body JSON.dump links: {
		self: '/api',
		heros: '/api/heros',
		abilities: '/api/abilities'
	}
end

get '/api/heros' do
	begin
		response = hero_service.fetch_all
		response_body = JSON.parse response.body, symolize_names: true

		raise 'Error acessing external service' unless response.code == 200
	rescue => e
		status 500
		return body 'Internal server error'
	end

	status 200
	headers 'Content-Type' => 'application/json; charset=utf-8'

	body JSON.dump response_body
end

get '/api/heros/:hero_id' do
	status 501
  body ''
end

get '/api/heros/:hero_id/abilities' do
	status 501
  body ''
end

get '/api/abilities' do
	status 501
  body ''
end

get '/api/abilities/:ability_id' do
	status 501
  body ''
end
