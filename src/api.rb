require 'sinatra'

get '/' do
	status 200
	headers \
		'Content-Type' => 'application/json; charset=utf-8'

	body '{}'
end
