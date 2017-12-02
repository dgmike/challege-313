require 'sinatra'
require 'json'
require './services/heros'
require './libs/request_filter'
require './mapper/collection_mapper'

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
		page, limit = RequestFilter.pagination_params params['page'], params['limit']

		response = hero_service.fetch_all page: page, limit: limit
		response_body = JSON.parse response.body, symolize_names: true

		raise 'Error acessing external service' unless response.code == 200
	rescue => e
		status 500
		return body 'Internal server error'
	end

	mapper = CollectionMapper.new '/api/heros', page, limit, response_body

	mapped_data = response_body['data'].map do |item|
		{
			type: 'hero',
			id: item['id'],
			attributes: {
				name: item['name'],
				real_name: item['real_name'],
				health: item['health'],
				armour: item['armour'],
				shield: item['shield'],
			},
			links: {
				self: "/api/heros/#{item['id']}",
				abilities: "/api/heros/#{item['id']}/abilities",
			},
		}
	end

	data = mapper.convert
	data[:data] = mapped_data

	status 200
	headers 'Content-Type' => 'application/json; charset=utf-8'

	body JSON.dump data
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
