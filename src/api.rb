require 'sinatra'
require 'json'
require './services/heros'
require './services/abilities'
require './libs/request_filter'
require './mapper/hero_mapper'
require './mapper/hero_abilities_mapper'
require './mapper/heros_collection_mapper'
require './mapper/abilities_collection_mapper'

hero_service = Heros.new
ability_service = Abilities.new

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
		page, limit = RequestFilter.pagination_params params['page'], params['limit']

		response = hero_service.fetch_all page: page, limit: limit
		response_body = JSON.parse response.body, symolize_names: true

		raise 'Error acessing external service' unless response.code == 200
	rescue
		status 500
		return body 'Internal server error'
	end

	mapper = HerosCollectionMapper.new '/api/heros', page, limit, response_body

	data = mapper.convert

	status 200
	headers 'Content-Type' => 'application/json; charset=utf-8'

	body JSON.dump data
end

get '/api/heros/:hero_id' do
	hero_id = params['hero_id']
	if hero_id =~ /\D/
		status 422
		return body 'Invalid hero id'
	end

	begin
		response = hero_service.fetch hero_id

		if response.code == 404
			status 404
			return body 'Hero not found'
		end

		raise 'Error acessing external service' unless response.code == 200

		response_body = JSON.parse response.body, symolize_names: true
	rescue
		status 500
		return body 'Internal server error'
	end

	status 200
	headers 'Content-Type' => 'application/json; charset=utf-8'

	body JSON.dump HeroMapper.new('/api/heros', response_body).convert
end

get '/api/heros/:hero_id/abilities' do
	hero_id = params['hero_id']
	if hero_id =~ /\D/
		status 422
		return body 'Invalid hero id'
	end

	begin
		response = hero_service.fetch hero_id

		if response.code == 404
			status 404
			return body 'Hero not found'
		end

		raise 'Error acessing external service' unless response.code == 200

		response_body = JSON.parse response.body, symolize_names: true
	rescue
		raise
		status 500
		return body 'Internal server error'
	end

	status 200
	headers 'Content-Type' => 'application/json; charset=utf-8'

	body JSON.dump HeroAbilitiesMapper.new("/v1", hero_id, response_body['abilities']).convert
end

get '/api/abilities' do
	begin
		page, limit = RequestFilter.pagination_params params['page'], params['limit']

		response = ability_service.fetch_all page: page, limit: limit
		response_body = JSON.parse response.body, symolize_names: true

		raise 'Error acessing external service' unless response.code == 200
	rescue
		status 500
		return body 'Internal server error'
	end

	mapper = AbilitiesCollectionMapper.new '/api/abilities', page, limit, response_body

	status 200
	headers 'Content-Type' => 'application/json; charset=utf-8'

	body JSON.dump mapper.convert
end

get '/api/abilities/:ability_id' do
	status 501
	body ''
end
