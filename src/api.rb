require 'sinatra'

get '/' do
	status 200
	headers \
		'Content-Type' => 'application/json; charset=utf-8'

	body '{}'
end

get '/api' do
	status 501
  body ''
end

get '/api/heros' do
	status 501
  body ''
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
